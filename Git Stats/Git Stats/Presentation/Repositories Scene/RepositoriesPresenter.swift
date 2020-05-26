//
//  RepositoriesPresenter.swift
//  Git Stats
//
//  Created by Jack Smith on 26/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import Foundation

protocol RepositoriesPresenterProtocol {
    func setView(_ view: RepositoriesPresenterDelegate)
}

protocol RepositoriesPresenterDelegate: class {
    func repositoriesPresenterDidProvideRepositoryData(_ presenter: RepositoriesPresenter, repositories: [Repository])
}

class RepositoriesPresenter {
    
    // MARK: - Properties
    
    private var view: RepositoriesPresenterDelegate
    private var user: User?
    
    // MARK: - Init
    
    init(_ view: RepositoriesPresenterDelegate) {
        self.view = view
        self.attemptFetchRepositoryData()
    }
    
    // MARK: - Methods
    
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
                    self.view.repositoriesPresenterDidProvideRepositoryData(self, repositories: repositories)
                case .failure(let error):
                    print("Error getting repositories: \(error.localizedDescription)")
                }
            }
        }
    }
}

extension RepositoriesPresenter: RepositoriesPresenterProtocol {
    
    func setView(_ view: RepositoriesPresenterDelegate) {
        self.view = view
    }
}
