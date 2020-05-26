//
//  LoginPresenter.swift
//  Git Stats
//
//  Created by Jack Smith on 24/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import Foundation

let USER_KEY = "USER_DEFAULTS_USER_KEY"

protocol LogInPresenterProtocol {
    func submitForm(_ username: String?)
}

protocol LogInPresenterDelegate: class {
    func logInPresenterDidRequestIncorrectFieldMask(_ loginPresenter: LogInPresenterProtocol)
    func loginPresenterDidRequestSegueToStatsScene(_ loginPresenter: LogInPresenterProtocol)
}

class LogInPresenter {
    
    // MARK: - Properties
    
    private var view: LogInPresenterDelegate
    private var username: String?
    
    // MARK: - Init
    
    init(_ view: LogInPresenterDelegate) {
        self.view = view
    }
    
    // MARK: - Methods
    
    private func attemptFetchUserData() {
        guard let username = self.isUsernameValid() else {
            self.view.logInPresenterDidRequestIncorrectFieldMask(self)
            return
        }
        
        self.performUserRequest(username)
    }
    
    private func performUserRequest(_ username: String) {
        let userService = GithubUserService(username: username)
        userService.getUser { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self.saveUserToUserDefaults(user: user)
                case .failure(let error):
                    print("Error getting user: \(error.localizedDescription)")
                    self.view.logInPresenterDidRequestIncorrectFieldMask(self)
                }
            }
        }
    }
    
    private func saveUserToUserDefaults(user: User) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: USER_KEY)
            self.view.loginPresenterDidRequestSegueToStatsScene(self)
        }
    }
    
    private func isUsernameValid() -> String? {
        return ValidationService.validateUsername(self.username)
    }
}

extension LogInPresenter: LogInPresenterProtocol {
    
    func submitForm(_ username: String?) {
        self.username = username
        self.attemptFetchUserData()
    }
}
