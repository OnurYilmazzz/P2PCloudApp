//
//  SignUpVC.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 5.11.2022.
//

import UIKit
import Foundation
import SQLite

class SignUpVC: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var mailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
            }
    
    
    @IBAction func signUpButton(_ sender: UIButton) {
          guard let name = self.nameTextField.text else {return}
         guard let email = self.mailTextField.text else {return}
         guard let password = self.passwordTextField.text else {return}
         let keyPair = Encryption.newKey()
        let key = keyPair?.publicKey ?? ""
        print(key)
        let signup = SignUpModel(name: name, email: email, password: password,public_key: key)
         APIManager.shareInstance.callingSignUpAPI(signup: signup){
         (isSucces, str) in
         if isSucces{
         self.openAlert(title: "Alert", message: str, alertStyle: .alert, actionTitles: ["Okey"], actionStyles: [.default],actions: [{_ in }])
         }else{
         self.openAlert(title: "Alert", message: str, alertStyle: .alert, actionTitles: ["Okey"], actionStyles: [.default],actions: [{_ in }])
         }
         
        if let loginVC = self.storyboard?.instantiateViewController(identifier: "LoginVC") as? LoginVC{
            self.navigationController?.pushViewController(loginVC, animated: true)}
             
             do{
               
                 try UserRepo().insertUser(userData: UserModel(id: 1, person: PersonModel(id: 1, name: name, email: email, publicKey: keyPair!.publicKey ), personId: 1, privateKey: keyPair!.privateKey))
                 print(try PersonRepo().findPerson(ids: 1))
             }
             catch{
                   
             }
    }
    
}
    
    
    @IBAction func loginHereButton(_ sender: UIButton) {
    if let loginVC = self.storyboard?.instantiateViewController(identifier: "LoginVC") as? LoginVC{
    self.navigationController?.pushViewController(loginVC, animated: true)
        
      /*  let encryptedData = Encryption.EncyrptData(input: "DENEME", publicKey:  "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAquWtOyBTRPvTd/9/qBAK6LWiU2KHfFDEXeVTsMowWqq7+lOK71+Xl+cZ7WML4IPB/MTrGe8eqIwsH6bTNqUsxvis6U1Qrn86gueM7fIULueDkOVuAGQiK7qds163z8nGmCtL94eiS77lUe+SeMLxwXc+s2sRn0Li0sTHqGcGNwlbF8RVGeDJO8MvqBwaso83K6MXSLRcWtivPJGYGxrRkoPsnP+MGHBTcfmWuadRToSlFlhwYnpC2zHjAj/bmGl0YUrGyOou0iq5KD/FhiLHOuDflZwvE9VZyY0ArgUvAtw8iVvIVVoZ8rNSFiipq0Pqyme4rzW56H2UCU4jkuHszQIDAQAB")
        
        print(encryptedData) */
    }
    }
   
}
                
