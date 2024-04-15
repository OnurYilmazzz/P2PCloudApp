//
//  MessageVC.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 6.01.2023.
//

import UIKit
import SocketIO
import SwiftyRSA

class MessageVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var chatMessages : [MessageModel] = []
    var contacts: [ContactDTO] = []
    var userCount: Int = 0
    
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "Onur"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.textField.delegate = self
        self.textField.becomeFirstResponder()
        
        
        
        SocketIOManager.sharedInstance.getmessages { (msg) in
            
            do {
                if let prkey = try UserRepo().findUser(id: 12)?.privateKey as? String {
                    if let decryptedMessage = Encryption.DecryptData(input: msg.message, privateKey: prkey) {
                        print("Decrypted message: \(decryptedMessage)")
                        print(prkey)
                    
                        self.chatMessages.insert(MessageModel(date: msg.date, time: msg.time, messageType: msg.messageType, message: decryptedMessage, to: ""), at: 0)
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print("ERROR")
            }

    }
             
    }
    @IBAction func sendMessage(_ sender: Any) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/M/YYYY"
        dateFormatter.string(from: date)
        
        let time = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let currentTime = timeFormatter.string(from: time)
        
        let messageTextField = textField.text ?? ""
        
    
                
        do {
            let pbkey = try PersonRepo().findPersonByEmail(personEmail: "onuryilmazceng@gmail.com")?.publicKey
            
            if try UserRepo().findUser(id: 12)?.privateKey is String {
                if let encryptedMessage = Encryption.EncyrptData(input: messageTextField, publicKey: pbkey ?? "") {
                    print("Encrypted message: \(encryptedMessage)")
                    
                    var messageModel = MessageModel(date: dateFormatter.string(from: date), time: currentTime, messageType: "send", message: encryptedMessage, to: "onuryilmazceng@gmail.com")
                    
                    let jsonEncoder = JSONEncoder()
                    let jsonData = try! jsonEncoder.encode(messageModel)
                    let json = String(data: jsonData, encoding: String.Encoding.utf8)
                    if let message = self.textField.text, message.isEmpty == false {
                        SocketIOManager.sharedInstance.contactSend(message: json!)
                        messageModel.message = messageTextField
                    
                        
                        
                        self.chatMessages.insert(messageModel, at: 0)
                        tableView.reloadData()
                        self.textField.text = ""
                        self.textField.resignFirstResponder()
                        
                        
                        
                    }
                    
                }
                
                
            }
            
        }
        
        catch {
            print("Error: \(error)")
        }
        
        
    }  
}

        extension MessageVC: UITableViewDelegate,UITableViewDataSource{
            func numberOfSections(in tableView: UITableView) -> Int {
                return 1
            }
            
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return chatMessages.count
            }
            func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
                
                let currentMessage = chatMessages[indexPath.row]
                if currentMessage.messageType != "send" {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "receivedMessageCell",for: indexPath) as! ReceivedMessageCell
                    cell.message.text = currentMessage.message
                    cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
                    return cell
                }
                let cell = tableView.dequeueReusableCell(withIdentifier: "sendMessageCell", for: indexPath ) as! SendMessageCell
                cell.message.text = currentMessage.message
                cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
                return cell
            }
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return UITableView.automaticDimension
            }
        }
        class ReceivedMessageCell: UITableViewCell {
            
            @IBOutlet weak var messageView: UIView!
            
            @IBOutlet weak var userName: UILabel!
            
            @IBOutlet weak var message: UILabel!
            var userNameTopConstraint: NSLayoutConstraint!
            var messageViewTopConstraint: NSLayoutConstraint!
            
            override func awakeFromNib() {
                messageView.layer.cornerRadius = 10
                
                self.messageViewTopConstraint = self.messageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8)
            }
        }
        class SendMessageCell: UITableViewCell {
            
            @IBOutlet weak var messageView: UIView!
            
            @IBOutlet weak var message: UILabel!
            
            var userNameTopConstraint: NSLayoutConstraint!
            var messageViewTopConstraint: NSLayoutConstraint!
            
            @IBOutlet weak var userName: UILabel!
            
            override func awakeFromNib() {
                messageView.layer.cornerRadius = 10
                
                self.messageViewTopConstraint = self.messageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8)
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
   
