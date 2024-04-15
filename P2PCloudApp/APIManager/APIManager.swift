//
//  APIManager.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 30.12.2022.
//

import Foundation
import Alamofire

enum APIErros: Error{
    case custom(message: String)
}
typealias Handler = (Swift.Result<Any?, APIErros>) -> Void
class APIManager{
    static let shareInstance = APIManager()
    
    func callingSignUpAPI(signup: SignUpModel, completionHandler: @escaping (Bool, String) -> ()){
        let headers : HTTPHeaders = [
            .contentType("application/json")
        ]
        
        AF.request(signup_url, method: .post, parameters: signup, encoder: JSONParameterEncoder.default, headers: headers).response{
            response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try  JSONSerialization.jsonObject(with: data!, options: [])
                    if response.response?.statusCode == 200 {
                        completionHandler(true, "Confirmation email has been sent")
                    }else{
                        completionHandler(false, "Please try again")
                    }
                    
                }catch{
                    print(error.localizedDescription)
                    completionHandler(false, "Please try again")
                }
            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(false, "Please try again")
            }
        }
    }
    
    func callingLoginAPI(login: LoginModeL, completionHandler: @escaping Handler){
        let headers : HTTPHeaders = [
            .contentType("application/json")
        ]
        
        AF.request(login_url, method: .post, parameters: login, encoder: JSONParameterEncoder.default, headers: headers).response{
            response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                
                do{
                    let json = try JSONDecoder().decode(ResponseModel.self, from: data!)
                    print(json)
                    //     let  json = try  JSONSerialization.jsonObject(with: data!, options: [])
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }else{
                        completionHandler(.failure(.custom(message: "Please check your network connectivity")))
                    }
                    
                }catch{
                    print(error.localizedDescription)
                    completionHandler(.failure(.custom(message:  "Please try againnn")))
                    
                }
            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(.failure(.custom(message:  "Please try again")))
            }
        }
    }
    func callingForgotPasswordAPI(forgotpassword: ForgotPasswordModel, completionHandler: @escaping (Bool, String) -> ()){
        let headers : HTTPHeaders = [
            .contentType("application/json")
        ]
        
        AF.request(forgotpassword_url, method: .post, parameters: forgotpassword, encoder: JSONParameterEncoder.default, headers: headers).response{
            response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try  JSONSerialization.jsonObject(with: data!, options: [])
                    if response.response?.statusCode == 200 {
                        completionHandler(true, "User register succesfully")
                    }else{
                        completionHandler(false, "Please try again")
                    }
                    
                }catch{
                    print(error.localizedDescription)
                    completionHandler(false, "Please try again")
                }
            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(false, "Please try again")
            }
        }
    }
    func callingGetUserDetailsByEmailAPI(email: String, completionHandler: @escaping (Bool, String)-> ()){
        let header : HTTPHeaders = [.contentType("application/json")]
        /*     let parameter: Parameters  = [
         "email": email
         ]*/
        
        AF.request(getuserdetailsbyemail_url + "?email=" + email, method: .get, headers: header).responseJSON { response in
            
            print(response.result)   // result of response serialization
            switch response.result {
            case .success(let data):
                if let jsonData = data as? Data{
                    do {
                        let json = try JSONDecoder().decode(UserDetailsModel.self, from: jsonData  )
                        print(json)
                        
                        
                        
                        
                        if response.response?.statusCode == 200 {
                            completionHandler(true, "User register succesfully")
                        }else{
                            completionHandler(false, "Please ")
                        }
                        
                    }catch {
                        print(error.localizedDescription)
                        completionHandler(false,  error.localizedDescription)
                    }
                }
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(false, " again")
                }
            }
        }
    }

