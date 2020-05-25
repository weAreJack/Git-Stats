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
}

protocol StatsPresenterDelegate: class {
    
}

class StatsPresenter {
    
    // MARK: - Properties
    
    weak private var view: StatsPresenterDelegate?
    
    private let loginService = LoginService()
    
    // MARK: - Methods
    
}

extension StatsPresenter: StatsPresenterProtocol {
    
    func setView(_ view: StatsPresenterDelegate) {
        self.view = view
    }
}
