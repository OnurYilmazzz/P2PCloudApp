//
//  PersonRepo.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 12.05.2023.
//

import Foundation
import SQLite

public class PersonRepo {
    
    let db = database.sharedInstance.db
    
    let persons = Table("persons")
    let id = Expression<Int64>("id")
    let publicKey = Expression<String>("publicKey")
    let name = Expression<String>("name")
    let email = Expression<String>("email")
    
    
    
    

    func insertPerson(personData: PersonModel) throws -> Int64 {
        let insert = persons.insert(publicKey <- personData.publicKey,
                                    name <- personData.name,
                                    email <- personData.email )
        let rowId = try db!.run(insert)
        return rowId
    }

    func updatePerson(personData: PersonModel) throws {
        let personId = personData.id
        let person = persons.filter(id == personId)
        let update = person.update(publicKey <- personData.publicKey,
                                   name <- personData.name,
                                   email <- personData.email)
        try db!.run(update)
    }

    func deletePerson(id: Int64) throws {
        let person = persons.filter(self.id == id)
        try db!.run(person.delete())
    }

    func findPerson(ids: Int64) throws -> PersonModel? {
        let person = persons.filter(id == ids)
        if let row = try db!.pluck(person) {
            
            let personModel = PersonModel(id: row[id], name: row[name], email: row[email], publicKey: row[publicKey])
           return personModel
        }
        return nil
    }

    func findPersonByEmail(personEmail: String) throws -> PersonModel? {
        let person = persons.filter(email == personEmail)
        if let row = try db!.pluck(person) {
            let personModel = PersonModel(id: row[id], name: row[name], email: row[email], publicKey: row[publicKey])
            return personModel
        }
        return nil
    }

    func getAllPersons() throws -> [PersonModel] {
        var allPersons: [PersonModel] = []
        for row in try db!.prepare(persons) {
            let person = PersonModel(id: row[id], name: row[name], email: row[email], publicKey: row[publicKey])
            
            allPersons.append(person)
        
        }
        return allPersons
    }

}
