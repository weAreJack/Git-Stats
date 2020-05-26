//
//  StatsPresenter.swift
//  Git Stats
//
//  Created by Jack Smith on 24/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import Foundation

protocol StatsPresenterProtocol {
    func forgetUserData()
}

protocol StatsPresenterDelegate: class {
    func statsPresenterDidProvideUserData(_ presenter: StatsPresenter, user: User, andStatCellViewModels viewModels: [StatTableViewCellViewModel])
}

class StatsPresenter {
    
    // MARK: - Properties
    
    private var view: StatsPresenterDelegate
    
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
            let viewModels = self.organiseStatCellViewModels(user: decodedUser)
            self.view.statsPresenterDidProvideUserData(self, user: decodedUser, andStatCellViewModels: viewModels)
        }
    }
    
    private func organiseStatCellViewModels(user: User) -> [StatTableViewCellViewModel] {
        var viewModels = [StatTableViewCellViewModel]()
        
        viewModels.append(StatTableViewCellViewModel(title: "Location", detailText: user.location, icon: #imageLiteral(resourceName: "locationIcon")))
        viewModels.append(StatTableViewCellViewModel(title: "Followers", detailText: "\(user.noFollowers ?? 0)", icon: #imageLiteral(resourceName: "followingIcon")))
        viewModels.append(StatTableViewCellViewModel(title: "Following", detailText: "\(user.noFollowing ?? 0)", icon: #imageLiteral(resourceName: "followingIcon")))
        viewModels.append(StatTableViewCellViewModel(title: "Repositories", detailText: "\(user.noOfRepos ?? .zero)", icon: #imageLiteral(resourceName: "repoIcon"), showsChevron: true))
        
        return viewModels
    }
}

extension StatsPresenter: StatsPresenterProtocol {
    
    func forgetUserData() {
        UserDefaults.standard.set(nil, forKey: USER_KEY)
    }
}
