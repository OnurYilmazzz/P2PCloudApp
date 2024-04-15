//
//  ForgotPasswordVC.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 5.11.2022.
//

import UIKit
class ForgotPasswordVC: UIViewController {
    
    @IBOutlet weak var mailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func resetPasswordButton(_ sender: Any) {
        let forgotpassword = ForgotPasswordModel(email: mailTextField.text!)
        APIManager.shareInstance.callingForgotPasswordAPI(forgotpassword: forgotpassword){
            (isSucces, str) in
            if isSucces{
                self.openAlert(title: "Alert", message: str, alertStyle: .alert, actionTitles: ["Okey"], actionStyles: [.default],actions: [{_ in }])
            }else{
                self.openAlert(title: "Alert", message: str, alertStyle: .alert, actionTitles: ["Check your mail adress"], actionStyles: [.default],actions: [{_ in }])
            }
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
}
