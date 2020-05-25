//
//  LoginService.swift
//  Git Stats
//
//  Created by Jack Smith on 24/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import Foundation

final class LoginService {
    
    func logIn(username: String,
               password: String,
               token: String,
               completion: @escaping (_ success: Bool) -> Void) {
        completion(true)
    }
}
