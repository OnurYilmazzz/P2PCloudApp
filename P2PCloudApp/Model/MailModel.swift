//
//  MailModel.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 20.05.2023.
//

import Foundation
struct MailModel: Encodable{
    var email: String
    
}


struct ContactRQModel: Codable {
    let status: String
    let contactData: ContactDataModel
}

struct ContactDataModel: Codable {
    let name: String
    let email: String
    let publicKey: String
}
