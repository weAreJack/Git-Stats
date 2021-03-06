//
//  LoginViewController.swift
//  Git Stats
//
//  Created by Jack Smith on 24/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var usernameField: RoundedTextField!
    @IBOutlet private weak var logInButton: RoundedButton!
    @IBOutlet weak var logInButtonActivityIndicator: UIActivityIndicatorView!
    
    private var presenter: LogInPresenterProtocol?
    private let loginSegueKey = "LogInSegue"
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = LogInPresenter(self)
    }
    
    // MARK: - Methods
    
    @IBAction func usernameFieldDidChangeText(_ sender: RoundedTextField) {
        self.usernameField.backgroundColor = .babyPowder
    }
    
    @IBAction func loginButtonTapped(_ sender: RoundedButton) {
        self.disableLogInButton()
        self.presenter?.submitForm(self.usernameField.text)
    }
    
    private func disableLogInButton() {
        self.logInButtonActivityIndicator.startAnimating()
        self.logInButton.isEnabled = false
        self.logInButton.backgroundColor = UIColor.indianRed.withAlphaComponent(0.5)
    }
    
    private func enableLogInButton() {
        self.logInButtonActivityIndicator.stopAnimating()
        self.logInButton.isEnabled = true
        self.logInButton.backgroundColor = UIColor.indianRed
    }
}

extension LogInViewController: LogInPresenterDelegate {
    
    func logInPresenterDidRequestIncorrectFieldMask(_ loginPresenter: LogInPresenterProtocol) {
        self.usernameField.backgroundColor = UIColor.indianRed.withAlphaComponent(1/3)
        self.enableLogInButton()
    }
    
    func loginPresenterDidRequestSegueToStatsScene(_ loginPresenter: LogInPresenterProtocol) {
        self.performSegue(withIdentifier: self.loginSegueKey, sender: self)
        self.usernameField.text = nil
        self.enableLogInButton()
    }
}
