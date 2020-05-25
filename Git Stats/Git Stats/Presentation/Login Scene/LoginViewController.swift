//
//  LoginViewController.swift
//  Git Stats
//
//  Created by Jack Smith on 24/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var usernameField: RoundedTextField!
    @IBOutlet private weak var passwordField: RoundedTextField!
    @IBOutlet private weak var logInButton: RoundedButton!
    
    private let presenter: LoginPresenterProtocol = LoginPresenter()
    
    private let loginSegueKey = "logInSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.setView(self)
    }
    
    @IBAction func usernameFieldDidChangeText(_ sender: RoundedTextField) {
        self.usernameField.backgroundColor = .babyPowder
    }
    
    @IBAction func passwordFieldDidChangeText(_ sender: RoundedTextField) {
        self.passwordField.backgroundColor = .babyPowder
    }
    
    @IBAction func loginButtonTapped(_ sender: RoundedButton) {
        let username = self.usernameField.text
        let password = self.passwordField.text
        
        self.presenter.submitFormForLogin(username, password)
    }
    
    private func applyIncorrectFieldsMask() {
        self.usernameField.backgroundColor = UIColor.indianRed.withAlphaComponent(1/3)
        self.passwordField.backgroundColor = UIColor.indianRed.withAlphaComponent(1/3)
    }
    
    private func clearFields() {
        self.usernameField.text = nil
        self.passwordField.text = nil
    }
}

extension LoginViewController: LoginPresenterDelegate {
    
    func logInPresenterDidRequestIncorrectFieldsMask(_ loginPresenter: LoginPresenterProtocol) {
        self.applyIncorrectFieldsMask()
    }
    
    func loginPresenterDidRequestSegueToStatsScene(_ loginPresenter: LoginPresenterProtocol) {
        self.performSegue(withIdentifier: self.loginSegueKey, sender: self)
        self.clearFields()
    }
}
