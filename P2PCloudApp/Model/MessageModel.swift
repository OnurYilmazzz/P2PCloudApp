//
//  MessageModel.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 6.01.2023.
//

import Foundation

struct MessageModel: Codable {
    var date: String
    var time: String
    var messageType: String
    var message:String
    var to: String
}
/*struct UserData {
    let username: String
    let status: Status
}
      
*/
