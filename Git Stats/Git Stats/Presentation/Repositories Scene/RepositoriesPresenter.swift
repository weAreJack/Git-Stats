//
//  RepositoriesPresenter.swift
//  Git Stats
//
//  Created by Jack Smith on 26/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import Foundation

protocol RepositoriesPresenterProtocol {
}

protocol RepositoriesPresenterDelegate: class {
    func repositoriesPresenterDidProvideViewModels(_ presenter: RepositoriesPresenter,
                                                   viewModels: [RepositoryTableViewCellViewModel])
}

class RepositoriesPresenter {
    
    // MARK: - Properties
    
    private var view: RepositoriesPresenterDelegate
    
    // MARK: - Init
    
    init(_ view: RepositoriesPresenterDelegate) {
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
            self.attemptFetchRepositoryData(forUser: decodedUser)
        }
    }
    
    private func attemptFetchRepositoryData(forUser user: User) {
        guard let username = user.username else {
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
                    let viewModels = self.convertToRepositoryCellViewModels(repositories: repositories)
                    self.view.repositoriesPresenterDidProvideViewModels(self, viewModels: viewModels)
                case .failure(let error):
                    print("Error getting repositories: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func convertToRepositoryCellViewModels(repositories: [Repository]) -> [RepositoryTableViewCellViewModel] {
        var viewModels = [RepositoryTableViewCellViewModel]()
        
        repositories.forEach { repository in
            viewModels.append(RepositoryTableViewCellViewModel(name: repository.name,
                                                               language: repository.language,
                                                               stars: repository.stars))
        }
        
        return viewModels
    }
}

extension RepositoriesPresenter: RepositoriesPresenterProtocol {
}
