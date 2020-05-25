//
//  ValidationService.swift
//  Git Stats
//
//  Created by Jack Smith on 25/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import Foundation

class ValidationService {
    
    static let minimumPasswordLength = 8
    
    static func validateUsername(_ username: String?) -> String? {
        guard let username = username else {
            return nil
        }
        
        // TODO: Find Githubs actual validation requirements
        let usernameRegEx = "[A-Z0-9a-z._%+-]{6,20}"
        let usernamePred = NSPredicate(format:"SELF MATCHES %@", usernameRegEx)
        
        return usernamePred.evaluate(with: username) ?  username : nil
    }
    
    static func validatePassword(_ password: String?) -> String? {
        guard let password = password else {
            return nil
        }
        
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: password)
        
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = texttest1.evaluate(with: password)
        
        let isLongEnough = password.count >= self.minimumPasswordLength
        return (capitalresult && numberresult && isLongEnough) ? password : nil
    }
}

