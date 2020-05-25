//
//  StatsViewController.swift
//  Git Stats
//
//  Created by Jack Smith on 24/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    @IBOutlet private weak var profileImageView: CircularImageView!
    @IBOutlet private weak var statsTableView: UITableView!
    @IBOutlet private weak var logOutButton: RoundedButton!
    
    private let presenter: StatsPresenterProtocol = StatsPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.setView(self)
    }
    
    @IBAction func logOutButtonTapped(_ sender: RoundedButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension StatsViewController: StatsPresenterDelegate {
    
}
