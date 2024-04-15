//
//  LoginModel.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 30.12.2022.
//

import UIKit
struct LoginModeL: Encodable{
    let email: String
    let password: String

}

struct LoginResponseModel{
    let name: String
    let password: String
    let data: String
}
