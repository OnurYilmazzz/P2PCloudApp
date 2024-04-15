//
//  ContactConversationRepo.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 18.05.2023.
//

import Foundation
import SQLite
public class ContactConversationRepo{

    let db = database.sharedInstance.db
    

    let contactConversation = Table("contact_conversations")
    let id = Expression<Int64>("id")
    let userId = Expression<Int64>("userId")
    let contactPersonId = Expression<Int64>("contactPersonId")
    let isFavorite = Expression<Bool>("isFavorite")

    func insertContactConversation(contactConversationData: ContactConversationModel) throws -> ContactConversationModel {
        let insert = contactConversation.insert(userId <- contactConversationData.userId,
                                                 contactPersonId <- contactConversationData.contactPersonId,
                                                 isFavorite <- contactConversationData.isFavorite)
        let rowId = try db!.run(insert)
        return try findContactConversation(id: (rowId))!
    }

    func updateContactConversation(contactConversationData: ContactConversationModel) throws -> ContactConversationModel {
        let update = contactConversation.filter(id == contactConversationData.id)
            .update(isFavorite <- contactConversationData.isFavorite)
        try db!.run(update)
        return try findContactConversation(id: contactConversationData.id)!
    }

    func deleteContactConversation(id: Int64) throws {
        let contactConversation = contactConversation.filter(self.id == id)
        try db!.run(contactConversation.delete())
    }

    func findContactConversation(id: Int64) throws -> ContactConversationModel? {
        let query = contactConversation.filter(self.id == id)
                                       .select(id, userId, contactPersonId, isFavorite)
        
        if let row = try db!.pluck(query) {
            return ContactConversationModel(id: id,
                                            userId: row[userId],
                                            contactPersonId: row[contactPersonId],
                                            isFavorite: row[isFavorite])
        }
        
        return nil
    }

    func getContactConversationsByUserId(userId: Int64) throws -> [ContactDTO] {
        let personRepo = PersonRepo()
        let query = contactConversation.join(personRepo.persons, on: personRepo.persons[id] == contactPersonId).filter(self.userId == userId).select(contactConversation[id],personRepo.name,isFavorite,personRepo.email,personRepo.publicKey)
    
        var contactConversations: [ContactDTO] = []
        for row in try db!.prepare(query) {
            let contactConversation = ContactDTO(id: row[id],name: row[personRepo.name], isFavorite: row[isFavorite], email: row[personRepo.email], publickey: row[personRepo.publicKey])
            contactConversations.append(contactConversation)
        }
        
        return contactConversations
    }


}
