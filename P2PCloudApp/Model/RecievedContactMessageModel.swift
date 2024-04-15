//
//  RecievedContactMessageModel.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 31.05.2023.
//

import Foundation
struct RecievedContactMessageModel: Codable {
    var date: String
    var time: String
    var messageType: String
    var message:String
    var from: String
}
