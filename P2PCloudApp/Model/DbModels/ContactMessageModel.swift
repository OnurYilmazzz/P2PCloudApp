//
//  ContactMessageModel.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 18.05.2023.
//

import Foundation
struct ContactMessageModel: Decodable{
    
    var id: Int64
    var contactConversationId: Int64
    var hashTableId: Int64
    var isSenderUser: Bool
    var messageType: String
    var message: String
    var date: String
    var time: String
}
