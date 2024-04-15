//
//  ContactRequestVC.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 2.06.2023.
import UIKit
import SQLite

class ContactRequestsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let tableView = UITableView()
    let contactReqRepo = ContactRequestNotificationRepo()
    var contactRequests: [RequestModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contact Requests"
        // Arka plan rengini beyaz yap
        view.backgroundColor = .white
        
        // TableView'ı oluştur ve düzenle
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ContactRequestCell.self, forCellReuseIdentifier: "ContactRequestCell")
        view.addSubview(tableView)
        
        
        
        
        
        // Görünümleri düzenleme
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        SocketIOManager.sharedInstance.contactRequest { contactRequest in
            self.contactRequests.insert(RequestModel(name: contactRequest.name , email: contactRequest.email, publicKey: contactRequest.publicKey), at: 0)
            
            self.tableView.reloadData()
        }
        
        
        
       
    }
    
   
    
    // MARK: - TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactRequests.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactRequestCell", for: indexPath) as! ContactRequestCell
        let contactRequest = contactRequests[indexPath.row]
        cell.configure(with: contactRequest)
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

class ContactRequestCell: UITableViewCell {
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    var publicKeyLabel = ""
    let acceptButton = UIButton()
    let rejectButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // İsim label'ını oluştur ve düzenle
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        // E-posta label'ını oluştur ve düzenle
        emailLabel.textAlignment = .left
        emailLabel.font = UIFont.systemFont(ofSize: 14)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emailLabel)
        
        // Kabul et butonunu oluştur ve düzenle
        let acceptImage = UIImage(named: "accept")
        acceptButton.setImage(acceptImage, for: .normal)
        acceptButton.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(acceptButton)
        
        // Reddet butonunu oluştur ve düzenle
        let rejectImage = UIImage(named: "reject")
        rejectButton.setImage(rejectImage, for: .normal)
        rejectButton.addTarget(self, action: #selector(rejectButtonTapped), for: .touchUpInside)
        rejectButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(rejectButton)
    
        // Görünümleri düzenleme
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            
            rejectButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rejectButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            rejectButton.widthAnchor.constraint(equalToConstant: 20),
            rejectButton.heightAnchor.constraint(equalToConstant: 20),

            acceptButton.trailingAnchor.constraint(equalTo: rejectButton.leadingAnchor, constant: -8),
            acceptButton.centerYAnchor.constraint(equalTo: rejectButton.centerYAnchor),
            acceptButton.widthAnchor.constraint(equalToConstant: 20),
            acceptButton.heightAnchor.constraint(equalToConstant: 20)



        ])
    }
    @objc func acceptButtonTapped(){
        do {
            let contactData = ContactDataModel(name: nameLabel.text!, email: emailLabel.text!, publicKey: publicKeyLabel)
            let  contactConversation = ContactConversationRepo()
            let person = PersonRepo()
            let personId = try person.insertPerson(personData: PersonModel(id: 1, name: nameLabel.text!, email: emailLabel.text!, publicKey: publicKeyLabel))
            try contactConversation.insertContactConversation(contactConversationData: ContactConversationModel(id: 1, userId: 1, contactPersonId: personId, isFavorite: true))
            
            self.removeFromSuperview()
        }catch{
            print(error.localizedDescription)
        }
    }
    
        
    @objc func rejectButtonTapped() {
        self.removeFromSuperview()
    }
    func configure(with request: RequestModel) {
           // Configure the cell with the provided request data
           nameLabel.text = request.name
           emailLabel.text = request.email
        publicKeyLabel = request.publicKey
        
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


    // Görün

