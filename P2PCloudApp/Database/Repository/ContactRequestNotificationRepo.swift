//
//  ContactRequestNotificationRepo.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 18.05.2023.
//

import Foundation
import SQLite

public class ContactRequestNotificationRepo{
    
    let db = database.sharedInstance.db
    
    let contactRequestNotification = Table("contactRequestNotification")
    let id = Expression<Int64>("id")
    let userId = Expression<Int64>("userId")
    let publicKey = Expression<String>("publicKey")
    let name = Expression<String>("name")
    let email = Expression<String>("email")
    
    func insertContactRequestNotification(notificationData: ContactRequestNotificationModel) throws -> Int64 {
        let insert = contactRequestNotification.insert(userId <- notificationData.userId,
                                          publicKey <- notificationData.publicKey,
                                          name <- notificationData.name,
                                          email <- notificationData.email)
        let rowId = try db!.run(insert)
        return rowId
    }
    
    func deleteContactRequestNotification(id: Int64) throws {
        let notification = contactRequestNotification.filter(self.id == id)
        try db!.run(notification.delete())
    }
    
    func findContactRequestNotificationById(id: Int64) throws -> [String: Any]? {
        let query = contactRequestNotification.filter(self.id == id)
        if let row = try db!.pluck(query) {
            let contactRequestNotModel = ContactRequestNotificationModel(id: id, userId: row[userId], name: row[name], email: row[email], publicKey: row[publicKey])        }
        return nil
    }
    
    func findContactRequestNotificationByEmail(email: String) throws -> [ContactRequestNotificationModel] {
        let query = contactRequestNotification.filter(self.email == email)
        var result: [ContactRequestNotificationModel] = []
        for row in try db!.prepare(query) {
            let contactRequestNotModel = ContactRequestNotificationModel(id: row[id], userId: row[userId], name: row[name], email: email, publicKey: row[publicKey])
            result.append(contactRequestNotModel)
        }
        return result
    }
    
    func getAllContactRequestNotifications() throws -> [ContactRequestNotificationModel] {
        var result: [ContactRequestNotificationModel] = []
        for row in try db!.prepare(contactRequestNotification) {
            let contactRequestNotModel = ContactRequestNotificationModel(id: row[id], userId: row[userId], name: row[name], email: row[email], publicKey: row[publicKey])
            result.append(contactRequestNotModel)
        }
        return result
    }
}

