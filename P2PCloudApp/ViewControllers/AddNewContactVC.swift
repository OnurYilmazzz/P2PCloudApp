//
//  AddNewContactVC.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 20.05.2023.
//
import Foundation
import UIKit
import SocketIO

class AddNewContactVC: UIViewController {
    
    let mailtextField = UITextField()
    let contactRequestButton = UIButton(type: .system)
    
    @objc func didTapButton(){
        
        SocketIOManager.sharedInstance.sendContactRequest(email:mailtextField.text!)
    
                
                
            }
        
        

    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        
        
        
        let stackView = UIStackView()
        mailtextField.placeholder = "Email"

        contactRequestButton.setTitle("Button", for: .normal)
        contactRequestButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 50

        stackView.addArrangedSubview(mailtextField)
        stackView.addArrangedSubview(contactRequestButton)
        
        
        contactRequestButton.backgroundColor = .systemBlue
        contactRequestButton.setTitleColor(.white, for: .normal)
        
        mailtextField.backgroundColor = .white
        mailtextField.textColor = UIColor.black
        
        
        contactRequestButton.layer.cornerRadius = 10
        mailtextField.layer.cornerRadius = 10
        
        contactRequestButton.layer.shadowColor = UIColor.black.cgColor
        contactRequestButton.layer.shadowOpacity = 0.5
        contactRequestButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        contactRequestButton.layer.shadowRadius = 4

        mailtextField.layer.shadowColor = UIColor.black.cgColor
        mailtextField.layer.shadowOpacity = 0.5
        mailtextField.layer.shadowOffset = CGSize(width: 2, height: 2)
        mailtextField.layer.shadowRadius = 4

        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        mailtextField.widthAnchor.constraint(equalToConstant: 310).isActive = true
        mailtextField.heightAnchor.constraint(equalToConstant: 58).isActive = true
        
        contactRequestButton.widthAnchor.constraint(equalToConstant: 310).isActive = true
        contactRequestButton.heightAnchor.constraint(equalToConstant: 58).isActive = true

        contactRequestButton.setTitle("Send Contact Request", for: .normal)
        
        mailtextField.autocapitalizationType = .none

        

        // StackView Constraints
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

       

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
