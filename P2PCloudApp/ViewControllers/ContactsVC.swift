//
//  ContactsVC.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 12.05.2023.
//


import UIKit
import SocketIO
import SQLite

class ContactsVC: UIViewController {

    
    
    @IBOutlet weak var contactsTableView: UITableView!
    let personRepo = PersonRepo()
    let contactconversationRepo = ContactConversationRepo()

    var contacts = [ContactDTO]()
    
    let message = ["Selam", "Anladım", "Teşekkürler"]
        override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contacts"
        view.backgroundColor = .gray
        
    
        
        configureItems()
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        
            
        do {
            
            contacts = try contactconversationRepo.getContactConversationsByUserId(userId: 1) // Kişiler veritabanından alınıyor
            contactsTableView.reloadData() // TableView güncelleniyor
        } catch {
            print("Dont get all persons : \(error)")
        }
    }
        

    private func configureItems(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapButton))
        

    }
    @objc func didTapButton () {
        let addContactvc = AddContactVC()
        addContactvc.title = "New contact/group"
        addContactvc.view.backgroundColor = .white
        addContactvc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButton))
        self.navigationController?.pushViewController(addContactvc, animated: true)
    }
    @objc func refreshButton(){
        do {
                contacts = try contactconversationRepo.getContactConversationsByUserId(userId: 1)
                contactsTableView.reloadData() //
            } catch {
                print("Dont get all persons : \(error)")
            }
    }
}

extension ContactsVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactsTableView.dequeueReusableCell(withIdentifier: "contactsCell") as! ContactsCell
        
        let personData = contacts[indexPath.row]
        let contacts = contacts[indexPath.row]
        let message = message[indexPath.row]
        cell.imageProfile.image = UIImage(named: "placeholderimage" )
        cell.nameLabel.text = personData.name
        cell.messageLabel.text = message
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let contact = contacts[indexPath.row]
            do {
                try contactconversationRepo.deleteContactConversation(id: contact.id)
                contacts.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                
            } catch {
                print("Kişi silinemedi: \(error)")
            }
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMessage", sender: self)
    }
    override  func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "toMessage" {
            let vc = segue.destination as! MessageVC
            
        }
    }
}
