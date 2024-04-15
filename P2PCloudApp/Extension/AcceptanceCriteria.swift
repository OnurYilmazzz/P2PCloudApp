//
//  AcceptanceCriteria.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 11.11.2022.
//

import Foundation

extension String{
    
    func validateName() -> Bool {
        let nameRegEx = "[A-Za-z]{1,255}"
        return applyPredicateOnRegex(regexStr: nameRegEx)
    }
    
    func validateMail() -> Bool {
        let mailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return applyPredicateOnRegex(regexStr: mailRegEx)
    }
    
    func validatePassword(mini: Int = 6, max: Int = 255) -> Bool {
        var passwordRegEx = ""
        if mini >= max{
            passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(mini),}$"
        }else{
            passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(mini),\(max)}$"
        }
        return applyPredicateOnRegex(regexStr: passwordRegEx)
    }
    
    
    func applyPredicateOnRegex(regexStr: String) -> Bool{
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateOtherString = NSPredicate(format: "SELF MATCHES %@", regexStr)
        let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
        return isValidateOtherString
    }
}

