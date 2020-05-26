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
        let usernameRegEx = "[A-Z0-9a-z._%+-]{4,30}"
        let usernamePred = NSPredicate(format:"SELF MATCHES %@", usernameRegEx)
        
        return usernamePred.evaluate(with: username) ?  username : nil
    }
}

