//
//  UserRepo.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 18.05.2023.
//


import Foundation
import SQLite

public class UserRepo {
    let db = database.sharedInstance.db
        

    let users = Table("users")
    let id = Expression<Int64>("id")
    var personId = Expression<Int64>("personId")
    let privateKey = Expression<String>("privateKey")
    let name = Expression<String>("name")
    let email = Expression<String>("email")
    let publicKey = Expression<String>("publicKey")
    
    
    

    func insertUser(userData:  UserModel) throws -> Int64 {
        let idOfPerson = try PersonRepo().insertPerson(personData: userData.person)
        let insert = users.insert(personId <- idOfPerson,
                                  privateKey <- userData.privateKey)
        let rowId = try db!.run(insert)
        return rowId
    }

    func updateUser(userData: UserModel) throws {
        let userId = userData.id
        let user = users.filter(id == userId)
        let update = user.update(privateKey <- userData.privateKey)
        try db!.run(update)
        
   //     let personData = user.toPerson(userData: userData)
    //    try PersonRepo.updatePerson(personData: personData)
    }

    func deleteUser(id: Int64) throws {
        let user = users.filter(self.id == id)
        try db!.run(user.delete())
    }

    
    
    func findUser(id: Int64) throws -> UserModel? {
        let user = users.filter(self.id == id)
                    if let row = try db!.pluck(user) {
                        let person = try  PersonRepo().findPerson(ids: row[personId])
                               let userModel = UserModel(id: id, person: person! , personId: row[personId], privateKey: row[privateKey])
                               return userModel
        
        }
        return nil
    }

    func findUserByPersonId(PersonId: Int64) throws -> UserModel? {
        let user = users.filter(personId == PersonId)
        
        if let row = try db!.pluck(user) {
            let userData: [UserModel] = []
            let person = PersonModel(id: row[personId], name: row[name], email: row[email], publicKey: row[publicKey])
            let userModel = UserModel(id:row[id] ,person: person, personId: row[personId], privateKey: row[privateKey])
                   return userModel
            
                
            
        }
        return nil
    }

    func findUserByEmail(useremail: String) throws -> UserModel? {
        let user = users.filter(email == useremail)
        if let row = try db!.pluck(user){
            let person = PersonModel(id: row[personId], name: row[name], email: row[email], publicKey: row[publicKey])
            let userModel = UserModel(id:row[id], person: person, personId: row[personId], privateKey: row[privateKey])
            
            return userModel
        }
                   return nil
        }
                
}
