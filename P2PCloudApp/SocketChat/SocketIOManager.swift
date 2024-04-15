//
//  SocketIOManager.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 31.12.2022.
//

import Foundation
import SocketIO
import KeychainSwift
class SocketIOManager: NSObject{
    let  token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDdmMzQxMjIxOTAyYzQyZjEzNGQ3OTQiLCJlbWFpbCI6Im9udXJ5aWxtYXo4NjdAZ21haWwuY29tIiwiaWF0IjoxNjg2MDU4MDQ2fQ.wsq51O-fmd1Xs2Q32Wbs9DGnd8RhkgXXHExvi9st5LY"
    
    static let sharedInstance = SocketIOManager()
    private var manager: SocketManager
    private var socket: SocketIOClient
    
    override init() {
        
        manager = SocketManager(socketURL: URL(string:"https://get.mehmetumit.me")!, config:
                                    [.path("/api/9af39c6a9f1335ae7ea6dd9208d9141b6204c69ac/socket.io"),.log(true),.extraHeaders(["token": self.token]), .forceWebsockets(true)])
        socket = manager.defaultSocket
        
        
        super.init()
        
    }
    
    func establishConnection(){
        socket.connect()
        
    }
    
    
    func contactSend(message: String){
        socket.emit("contactChatMessage", message)
    }
    func sendOnline( name: String){
        socket.emitWithAck("online", name).timingOut(after: 0) {
            data in
        }}
    
    
    
    func getOnline(){
        socket.on("online"){ data ,ack in
            print("Online", data[0])
        }
    }
    func errorCheck(){
        socket.on("connect_error"){ data,ack  in
            print("x", data)
        }}
    func sendContactRequest(email: String){
        
        let jsonEncoder = JSONEncoder()
        let emaildata = try! jsonEncoder.encode(MailModel(email: email))
        let json = String(data: emaildata, encoding: String.Encoding.utf8)
        
        socket.emitWithAck("sendContactRequest",json! ).timingOut(after: 0) {data in
            
            let decoder = JSONDecoder()
            do {
                
                let jsonData = try JSONSerialization.data(withJSONObject: data[0], options: [])
                let getmsg = try decoder.decode(ContactRQModel.self, from: jsonData).contactData
                
                
                let contactData = ContactDataModel(name: getmsg.name, email: getmsg.email, publicKey: getmsg.publicKey)
                let  contactConversation = ContactConversationRepo()
                let person = PersonRepo()
                let personId = try person.insertPerson(personData: PersonModel(id: 1, name: getmsg.name, email: getmsg.email, publicKey: getmsg.publicKey))
                try contactConversation.insertContactConversation(contactConversationData: ContactConversationModel(id: 1, userId: 1, contactPersonId: personId, isFavorite: true))
                print(personId)
                
            }catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    func getmessages(handler: @escaping (_ message: RecievedContactMessageModel) -> Void){
        socket.on("contactChatMessage"){ data, ack in
            let message = data[0]
            let decoder = JSONDecoder()
            
            do {
                let jsonData = data[0] as! String
                let msg = try decoder.decode(RecievedContactMessageModel.self, from: Data(jsonData.utf8))
                handler(msg)
                print(msg)
                
            } catch {
                print(error.localizedDescription)
            }
            
            
        }
    }
    func contactRequest(handler: @escaping(_ contactRequest: RequestModel) -> Void){
        socket.on("contactRequestReceived"){ data, ack
            in
            let request = data[0]
            let decoder = JSONDecoder()
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data[0], options: [])
                let req = try decoder.decode(RequestModel.self, from: jsonData)
                handler(req)
                print(req)
            }catch{
                print(error.localizedDescription)
            }
    }
        
        
    }
    
    
}
