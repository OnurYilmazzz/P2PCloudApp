//
//  AddContactVC.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 20.05.2023.
//

import UIKit

class AddContactVC: UIViewController {

    
    @objc func button1Tapped(){
        let addNewContactvc = AddNewContactVC()
        addNewContactvc.view.backgroundColor = .white
        addNewContactvc.title = "Add New Contact"
        self.navigationController?.pushViewController(addNewContactvc, animated: true)
        
        }
    @objc func extraButtonTapped() {
        // Handle the notification button tap
        let contactRequestVC = ContactRequestsVC()
            self.navigationController?.pushViewController(contactRequestVC, animated: true)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let extraButton = UIButton(type: .custom)
        extraButton.frame = CGRect(x: view.frame.width - 60, y: 90, width: 50, height: 50)
        extraButton.backgroundColor = .red
        let buttonImage = UIImage(named: "notification")
        extraButton.setImage(buttonImage, for: .normal)
        extraButton.addTarget(self, action: #selector(extraButtonTapped), for: .touchUpInside)
        
        extraButton.layer.cornerRadius = 20
        

        view.addSubview(extraButton)
        
        
        
        
        
        let newContactButton = UIButton(frame: CGRect(x: 1.5, y: 136, width: 310, height: 58))
        let newGroupButton = UIButton(frame: CGRect(x: 1.5, y: 136, width: 310, height: 58))
        newContactButton.center = CGPoint(x: view.center.x, y: view.center.y - 50)
        newGroupButton .center = CGPoint(x: view.center.x, y: view.center.y + 50)
        
        newContactButton.backgroundColor = .white
        newContactButton.setTitleColor(.systemBlue, for: .normal)
        
        newGroupButton.backgroundColor = .systemBlue
        newGroupButton.setTitleColor(.white, for: .normal)
        
        newContactButton.layer.cornerRadius = 20
        newGroupButton.layer.cornerRadius = 20
        
        newContactButton.layer.shadowColor = UIColor.black.cgColor
        newContactButton.layer.shadowOpacity = 0.5
        newContactButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        newContactButton.layer.shadowRadius = 4

        newGroupButton.layer.shadowColor = UIColor.black.cgColor
        newGroupButton.layer.shadowOpacity = 0.5
        newGroupButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        newGroupButton.layer.shadowRadius = 4


        view.addSubview(newContactButton)
        view.addSubview(newGroupButton)
        newContactButton.setTitle("Add New Contact", for: .normal)
        newGroupButton.setTitle("Create New Group", for: .normal)
        
        newContactButton.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        
    
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
