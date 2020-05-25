//
//  LoginPresenter.swift
//  Git Stats
//
//  Created by Jack Smith on 24/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import Foundation

protocol LoginPresenterProtocol {
    func setView(_ view: LoginPresenterDelegate)
    func submitFormForLogin(_ username: String?, _ password: String?)
}

protocol LoginPresenterDelegate: class {
    func logInPresenterDidRequestIncorrectFieldsMask(_ loginPresenter: LoginPresenterProtocol)
    func loginPresenterDidRequestSegueToStatsScene(_ loginPresenter: LoginPresenterProtocol)
}

class LoginPresenter {
    
    // MARK: - Properties
    
    weak private var view: LoginPresenterDelegate?
    
    private var username: String?
    private var password: String?
    
    private let loginService = LoginService()
    
    // MARK: - Methods
    
    private func attemptLogIn() {
        guard let username = self.isUsernameValid(), let password = self.isPasswordValid() else {
            self.view?.logInPresenterDidRequestIncorrectFieldsMask(self)
            return
        }
        
        self.loginService.logIn(username: username,password: password, token: "DUMMY_TOKEN") { authenticated in
            if authenticated {
                self.view?.loginPresenterDidRequestSegueToStatsScene(self)
            }
        }
    }
    
    private func isUsernameValid() -> String? {
        return ValidationService.validateUsername(self.username)
    }
    
    private func isPasswordValid() -> String? {
        return ValidationService.validatePassword(self.password)
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    
    func submitFormForLogin(_ username: String?, _ password: String?) {
        self.username = username
        self.password = password
        self.attemptLogIn()
    }
    
    func setView(_ view: LoginPresenterDelegate) {
        self.view = view
    }
}
