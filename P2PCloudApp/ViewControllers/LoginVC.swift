//
//  LoginVC.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 10.11.2022.
//

import UIKit
import SocketIO
import KeychainSwift

class LoginVC: UIViewController {

    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func forgotPasswordButton(_ sender: UIButton) {
        
        if let forgotPasswordVC = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as? ForgotPasswordVC{
            self.navigationController?.pushViewController(forgotPasswordVC, animated: true)
        }
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
      
        guard let email = mailTextField.text else{return}
        guard let password = passwordTextField.text else{return}
        let modelLogin = LoginModeL(email: email, password: password)
        APIManager.shareInstance.callingLoginAPI(login: modelLogin){
            (result) in
            switch result{
            case .success(let json):
                print(json)
                
                let decoder = JSONDecoder()
                let res =  try? decoder.decode(ResponseModel.self, from: json as! Data)
                print(res?.data ?? "")
                
                
                let name = ((json as! ResponseModel).name)
                let password = ((json as! ResponseModel).password)
                
            
               
              case .failure(let err):
                print(err.localizedDescription)
                
                
            }
            SocketIOManager.sharedInstance.establishConnection()
        }
        
        
        
        if let chatlistVC =
             self.storyboard?.instantiateViewController(withIdentifier: "ContactsVC") as? ContactsVC{
            self.navigationController?.pushViewController(chatlistVC, animated: true)
        }
   /*    if let contactListVC =
                   self.storyboard?.instantiateViewController(withIdentifier: "MessageVC") as? MessageVC{
                   self.navigationController?.pushViewController(contactListVC, animated: true)
            
           

               }
    
        */
    }
    
    @IBAction func signUpHereButton(_ sender: UIButton) {
        if let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as?
            SignUpVC{
            self.navigationController?.pushViewController(signUpVC, animated: true)
            
        }
        
    }
   
}
