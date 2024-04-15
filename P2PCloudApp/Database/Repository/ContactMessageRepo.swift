//
//  ContactMessageRepo.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 18.05.2023.
//

import Foundation
import SQLite

public class ContactMessageRepo {
    
    let db = database.sharedInstance.db
    
    let contactMessages = Table("contactMessage")
    let id = Expression<Int64>("id")
    let contactConversationId = Expression<Int64>("contactConversationId")
    let hashTableId = Expression<Int64>("hashTableId")
    let isSenderUser = Expression<Bool>("isSenderUser")
    let message = Expression<String>("message")
    let messageType = Expression<String>("messageType")
    let date = Expression<String>("date")
    let time = Expression<String>("time")
    
    func insertContactMessage(messageData: ContactMessageModel) throws -> Int64 {
        let insert = contactMessages.insert(contactConversationId <- messageData.contactConversationId,
                                            hashTableId <- messageData.hashTableId,
                                            isSenderUser <- messageData.isSenderUser,
                                            message <- messageData.message,
                                            messageType <- messageData.messageType,
                                            date <- messageData.date,
                                            time <- messageData.time)
        let rowId = try db!.run(insert)
        return rowId
    }
    
    func getMessagesByContactConversationId(contactConversationId: Int64) throws -> [Row] {
        let query = contactMessages.filter(self.contactConversationId == contactConversationId)
        let messages = try db!.prepare(query)
        return Array(messages)
    }
    
    func updateContactMessage(messageData: ContactMessageModel) throws {
        let messageId = messageData.id
        let message = contactMessages.filter(id == messageId)
        let update = message.update(contactConversationId <- messageData.contactConversationId,
                                    hashTableId <- messageData.hashTableId,
                                    isSenderUser <- messageData.isSenderUser,
                                    self.message <- messageData.message,
                                    messageType <- messageData.messageType,
                                    date <- messageData.date,
                                    time <- messageData.time )
        try db!.run(update)
    }
    
    func deleteContactMessage(id: Int64) throws {
        let message = contactMessages.filter(self.id == id)
        try db!.run(message.delete())
    }
    
    func findContactMessage(id: Int64) throws -> [ContactMessageModel]? {
        let query = contactMessages.filter(self.id == id)
        if let row = try db!.pluck(query) {
            let contactMsgModel = ContactMessageModel(id: id, contactConversationId: row[contactConversationId], hashTableId: row[hashTableId], isSenderUser: row[isSenderUser], messageType: row[messageType], message: row[message], date: row[date], time: row[time])
            
        }
        return nil
    }
    
    func getContactMessagesByContactConversationId(contactConversationId: Int64) throws -> [Row] {
        let query = contactMessages.filter(self.contactConversationId == contactConversationId)
        let messages = try db!.prepare(query)
        return Array(messages)
    }
    
    func getLastContactMessageByContactConversationId(contactConversationId: Int64) throws -> [ContactMessageModel]? {
        let query = contactMessages.filter(self.contactConversationId == contactConversationId)
            .order(id.desc)
            .limit(1)
        if let row = try db!.pluck(query){
            let contactMsgModel = ContactMessageModel(id: row[id], contactConversationId: row[id], hashTableId: row[hashTableId], isSenderUser: row[isSenderUser], messageType: row[messageType], message: row[message], date: row[date], time: row[time])
        }
        return nil
        
        
        
    }
}
