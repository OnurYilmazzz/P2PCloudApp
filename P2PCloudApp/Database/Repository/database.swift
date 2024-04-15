//
//  database.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 12.05.2023.
//

import Foundation
import SQLite


public class database {
    static let sharedInstance = database()
    var db : Connection!
    init() {
        do{
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let dbFile = "\(path.first ?? "" )/db.sqlite3"
               print(dbFile)   // show full file path
               db = try Connection(dbFile)
              initDatabase()
            
        }
        catch{
            print(error)
        }
       
    }
    func initDatabase(){
        do{
        
            try db.execute("""
                BEGIN TRANSACTION;
                CREATE TABLE IF NOT EXISTS users (
                 id INTEGER PRIMARY KEY AUTOINCREMENT,
                 personId INTEGER NOT NULL UNIQUE,
                 privateKey TEXT NOT NULL,
                 FOREIGN KEY(personId) REFERENCES persons(id) ON DELETE CASCADE);
                COMMIT TRANSACTION;
                BEGIN TRANSACTION;
                CREATE TABLE IF NOT EXISTS persons(
                 id INTEGER PRIMARY KEY AUTOINCREMENT,
                 publicKey TEXT NOT NULL,
                 name TEXT NOT NULL,
                 email TEXT NOT NULL UNIQUE);
                 CREATE TABLE IF NOT EXISTS auth_token(
                 id INTEGER PRIMARY KEY,
                 userId INTEGER NOT NULL UNIQUE,
                 data TEXT NOT NULL,
                 FOREIGN KEY(userId) REFERENCES users(id) ON DELETE CASCADE);
                COMMIT TRANSACTION;
                BEGIN TRANSACTION;
                CREATE TABLE IF NOT EXISTS hash_tables(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  previousHashId INTEGER NOT NULL UNIQUE DEFAULT 0,
                  conversationId INTEGER NOT NULL,
                  previousHashValue TEXT NOT NULL,
                  hashMessageData TEXT NOT NULL,
                  hashValue TEXT NOT NULL,
                  FOREIGN KEY(previousHashId) REFERENCES hash_tables(id));
                COMMIT TRANSACTION;
                BEGIN TRANSACTION;
                CREATE TABLE IF NOT EXISTS contact_request_notifications(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  userId INTEGER NOT NULL,
                  publicKey TEXT NOT NULL,
                  name TEXT NOT NULL,
                  email TEXT NOT NULL,
                  UNIQUE(userId, email),
                  FOREIGN KEY(userId) REFERENCES users(id) ON DELETE CASCADE);
                COMMIT TRANSACTION;
                BEGIN TRANSACTION;
                CREATE TABLE IF NOT EXISTS group_request_notifications(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  userId INTEGER NOT NULL,
                  key TEXT NOT NULL,
                  name TEXT NOT NULL,
                  description TEXT NOT NULL,
                  UNIQUE(userId, key, name, description),
                  FOREIGN KEY(userId) REFERENCES users(id) ON DELETE CASCADE);
                COMMIT TRANSACTION;
                BEGIN TRANSACTION;
                CREATE TABLE IF NOT EXISTS contact_conversations(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  contactPersonId INTEGER NOT NULL,
                  userId INTEGER NOT NULL,
                  isFavorite INTEGER NOT NULL DEFAULT 0,
                  UNIQUE(userId, contactPersonId),
                  FOREIGN KEY(contactPersonId) REFERENCES persons(id),
                  FOREIGN KEY(userId) REFERENCES users(id));
                COMMIT TRANSACTION;
                BEGIN TRANSACTION;
                CREATE TABLE IF NOT EXISTS contact_messages(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  contactConversationId INTEGER NOT NULL,
                  hashTableId INTEGER NULL,
                  isSenderUser INTEGER NOT NULL,
                  message TEXT NOT NULL,
                  messageType TEXT,
                  date TEXT NOT NULL,
                  time TEXT NOT NULL,
                  FOREIGN KEY(contactConversationId) REFERENCES contact_conversations(id) ON DELETE CASCADE,
                  FOREIGN KEY(hashTableId) REFERENCES hash_tables(id));
                COMMIT TRANSACTION;
                BEGIN TRANSACTION;
                CREATE TABLE IF NOT EXISTS group_conversations(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  userId INTEGER NOT NULL,
                  adminId INTEGER NOT NULL,
                  groupKey TEXT NOT NULL,
                  name TEXT NOT NULL,
                  description TEXT NOT NULL,
                  isFavorite INTEGER NOT NULL DEFAULT 0,
                  UNIQUE(userId, adminId, groupKey, name),
                  FOREIGN KEY(userId) REFERENCES users(id),
                  FOREIGN KEY(adminId) REFERENCES persons(id));
                COMMIT TRANSACTION;
                BEGIN TRANSACTION;
                CREATE TABLE IF NOT EXISTS group_messages(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  senderPersonId INTEGER NOT NULL,
                  groupConversationId INTEGER NOT NULL,
                  hashTableId INTEGER NULL,
                  message TEXT NOT NULL,
                  messageType TEXT,
                  date TEXT NOT NULL,
                  time TEXT NOT NULL,
                  FOREIGN KEY(groupConversationId) REFERENCES group_conversations(id) ON DELETE CASCADE,
                  FOREIGN KEY(senderPersonId) REFERENCES persons(id),
                  FOREIGN KEY(hashTableId) REFERENCES hash_tables(id));
                COMMIT TRANSACTION;
            BEGIN TRANSACTION;
                CREATE TABLE IF NOT EXISTS person_groups(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  groupConversationId INTEGER NOT NULL,
                  personId INTEGER NOT NULL,
                  UNIQUE(personId, groupConversationId),
                  FOREIGN KEY(groupConversationId) REFERENCES group_conversations(id) ON DELETE CASCADE,
                  FOREIGN KEY(personId) REFERENCES persons(id));
                COMMIT TRANSACTION;
            """)
        }
        catch {
            print(error.localizedDescription)
            return
        }
    }
}
