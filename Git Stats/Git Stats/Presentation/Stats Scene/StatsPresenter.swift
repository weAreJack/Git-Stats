//
//  StatsPresenter.swift
//  Git Stats
//
//  Created by Jack Smith on 24/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import Foundation

protocol StatsPresenterProtocol {
    func setView(_ view: StatsPresenterDelegate)
    func forgetUserData()
}

protocol StatsPresenterDelegate: class {
    func statsPresenterDidProvideUserData(_ presenter: StatsPresenter, user: User)
    func statsPresenterDidProvideRepositoryData(_ presenter: StatsPresenter, repositories: [Repository])
}

class StatsPresenter {
    
    // MARK: - Properties
    
    private var view: StatsPresenterDelegate
    private var user: User?
    
    init(_ view: StatsPresenterDelegate) {
        self.view = view
        self.getUser()
    }
    
    // MARK: - Methods
    
    private func getUser() {
        guard let user = UserDefaults.standard.object(forKey: USER_KEY) as? Data else {
            return
        }
        
        let decoder = JSONDecoder()
        if let decodedUser = try? decoder.decode(User.self, from: user) {
            print(decodedUser.name)
            self.view.statsPresenterDidProvideUserData(self, user: decodedUser)
            self.user = decodedUser
            self.attemptFetchRepositoryData()
        }
    }
    
    private func attemptFetchRepositoryData() {
        guard let username = self.user?.username else {
            return
        }
        
        self.performRepositoryRequest(username)
    }
    
    private func performRepositoryRequest(_ username: String) {
        let userService = GithubUserService(username: username)
        userService.getRepositories { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let repositories):
                    self.view.statsPresenterDidProvideRepositoryData(self, repositories: repositories)
                case .failure(let error):
                    print("Error getting repositories: \(error.localizedDescription)")
                }
            }
        }
    }
}

extension StatsPresenter: StatsPresenterProtocol {
    
    func forgetUserData() {
        UserDefaults.standard.set(nil, forKey: USER_KEY)
    }
    
    func setView(_ view: StatsPresenterDelegate) {
        self.view = view
    }
}
