//
//  GroupRequestNotificationRepo.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 18.05.2023.
//

import Foundation
import SQLite

public class GroupRequestNotificationRepo{
    
    let db = database.sharedInstance.db
    let groupRequestNotification = Table("groupRequestNotification")
    let id =  Expression<Int64>("id")
    let userId = Expression<Int64>("userId")
    let key = Expression<String>("key")
    let name = Expression<String>("name")
    let groupDescription = Expression<String>("description")
    
    func insertGroupRequestNotification(notificationData: GroupRequestNotificationModel) throws {
        let insert = groupRequestNotification.insert(
            userId <- notificationData.userId,
            key <- notificationData.key,
            name <- notificationData.name,
            groupDescription <- notificationData.groupDescription
        )
        try db!.run(insert)
    }
    
    func deleteGroupRequestNotification(id: Int64) throws {
        let notification = groupRequestNotification.filter(self.id == id)
        try db!.run(notification.delete())
    }
    
    func findGroupRequestNotificationById(id: Int64) throws -> [String: Any]? {
        let query = groupRequestNotification.filter(self.id == id)
            .select(userId, key, name, groupDescription)
        
        if let row = try db!.pluck(query) {
            let groupRequestNot = GroupRequestNotificationModel(id: id, userId: row[userId], key: row[key], name: row[name], groupDescription: row[groupDescription])
            
            
        }
        
        return nil
    }
    
    func getAllGroupRequestNotifications() throws -> [[String: Any]] {
        let query = groupRequestNotification.select(userId, key, name, groupDescription)
        
        var notifications: [[String: Any]] = []
        for row in try db!.prepare(query) {
            let groupRequestNot = GroupRequestNotificationModel(id: row[id], userId: row[userId], key: row[key], name: row[name], groupDescription: row[groupDescription])
            
        }
        return notifications
    }
}
