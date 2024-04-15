//
//  RegisterModel.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 30.12.2022.
//

import Foundation

struct SignUpModel: Encodable {
    let name : String
    let email : String
    let password : String
    let public_key : String
    
}
// MARK: - Welcome
struct ResponseModel: Codable {
    let id, publicKey, name, email, data: String
    let password: String
    let activeConversations: [String]
    let verified: Bool
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case publicKey = "public_key"
        case name, email, password,data
        case activeConversations = "active_conversations"
        case verified = "verified"
        case v = "__v"
    }
}
