//
//  UserDetailsVC.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 30.05.2023.
//

import UIKit
import SQLite

class UserDetailsVC: UIViewController {
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let publicKeyLabel = UILabel()
    var contacts : [ContactDTO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Arka plan rengini beyaz yap
        view.backgroundColor = .white
        
        // Profil fotoğrafı görünümünü ekle
        profileImageView.image = UIImage(named: "placeholderimage")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)
        
        // İsim label'ını oluştur ve düzenle
        nameLabel.text = "Mehmet"
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        // E-posta label'ını oluştur ve düzenle
        emailLabel.text = "ozdenmehmetumit@gmail.com"
        emailLabel.textAlignment = .center
        emailLabel.font = UIFont.systemFont(ofSize: 18)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailLabel)
        
        // Private key label'ını oluştur ve düzenle
         publicKeyLabel.text = "Public Key: MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsjbrfWTu8AYN9RWmaeyoEHrLxvT+U/1mw1cSxy5MUwSXzAqZGKRxUbEz9lBgeJyHgm72Xmn8wf4hgNkenmTZ/Bd0SkfheTU8Oh2SsAAV/wb9m/h9BQ44At65RUj0hXSRs+gTgmnpc5ha0F6inTTEsPT5bDhhh6ug2j887ZhZ/wGL4KJcgAgjsdGj8WlWf9NXuBkawljH730NZZcQfxLwE0atuNWFi1Fd5dI0RwlpSEy5MLTMm3KFfeaKN4H16tlknHSYOVhP95J1w2WLUK5AECodQnO1vnSzVXYRjSkMMZQvu1fI7KQmKvNjR3tO8gpSKc26w/yEcuZu38DYC+X+JQIDAQAB"
        
        publicKeyLabel.textAlignment = .center
        publicKeyLabel.font = UIFont.systemFont(ofSize: 16)
        publicKeyLabel.numberOfLines = 0
        publicKeyLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(publicKeyLabel)
        
        
       /* getUserDetails()
        
        
        func getUserDetails() {
            do {
                let userRepo = UserRepo()
                let user = try userRepo.findUserByEmail(useremail: "ozdenmehmetumit@gmail.com")
                
                if let user = user {
                    let person = try PersonRepo().findPerson(ids: user.personId)
                    
                    if let person = person {
                        nameLabel.text = person.name
                        emailLabel.text = person.email
                        publicKeyLabel.text = "Public Key: \(person.publicKey)"
                    }
                }
            } catch {
                print("Error fetching data from database: \(error)")
            } */
            
            // Görünümleri düzenleme
            NSLayoutConstraint.activate([
                profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                profileImageView.widthAnchor.constraint(equalToConstant: 120),
                profileImageView.heightAnchor.constraint(equalToConstant: 120),
                
                nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
                
                emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
                
                publicKeyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                publicKeyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                publicKeyLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
            ])
        }
    }
    

