//
//  Encryption.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 12.05.2023.
//

import Foundation
import SwiftyRSA

class Encryption {
    
  
    
    static func EncyrptData(input: String, publicKey: String) -> String?
    {
        do {
            let publicKey = try PublicKey(base64Encoded: publicKey)
            let clear = try ClearMessage(string: input, using: .utf8)
            let encrypted = try clear.encrypted(with: publicKey, padding: .PKCS1)
            
            let base64String = encrypted.base64String
            print(base64String)
            return encrypted.base64String
        }
        catch {
            print(error)
            return nil
        }
        
        
        
    }
    
    static func DecryptData(input: String,privateKey: String) -> String?
    {
        
        do{
            let privateKey = try PrivateKey(base64Encoded: privateKey)
            let encrypted = try EncryptedMessage(base64Encoded: input)
            let clear = try encrypted.decrypted(with: privateKey , padding: .PKCS1)
            
            let data = clear.data
            let decryptedString = try clear.string(encoding: .utf8)
            return decryptedString
        }
        catch {
            print(error)
            return nil
        }
        
       
    }
    
    
   static func newKey() -> Keymodel?{
        do{
            let keyPair = try SwiftyRSA.generateRSAKeyPair(sizeInBits: 2048)
            let privateKey = try keyPair.privateKey.base64String()
        
            let publicKey =  try keyPair.publicKey.base64String()
        
           
            return Keymodel(privateKey: privateKey, publicKey: publicKey)
        }
        catch{
            return nil
        }
       
    }
}
