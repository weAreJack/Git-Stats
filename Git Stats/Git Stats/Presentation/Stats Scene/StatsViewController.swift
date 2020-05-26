//
//  StatsViewController.swift
//  Git Stats
//
//  Created by Jack Smith on 24/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import UIKit
import SDWebImage

class StatsViewController: UIViewController {
    
    @IBOutlet private weak var profileImageView: CircularImageView!
    @IBOutlet private weak var statsTableView: UITableView!
    @IBOutlet private weak var logOutButton: RoundedButton!
    @IBOutlet private weak var usernameLabel: UILabel!
    
    private lazy var presenter: StatsPresenterProtocol = StatsPresenter(self)
    private let cellReuseId = "cell"
    
    private var cellModels = [StatTableViewCellViewModel]() {
        didSet {
            self.statsTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureViews()
    }
    
    @IBAction func logOutButtonTapped(_ sender: RoundedButton) {
        self.presenter.forgetUserData()
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureViews() {
        self.presenter.setView(self)
        self.statsTableView.delegate = self
        self.statsTableView.dataSource = self
        
        let cellNib = UINib(nibName: "StatTableViewCell", bundle: nil)
        self.statsTableView.register(cellNib, forCellReuseIdentifier: self.cellReuseId)
    }
    
    private func setProfileImage(withUrlString urlString: String?) {
        guard let urlString = urlString else {return}
        let url = URL(string: urlString)
        self.profileImageView.sd_setImage(with: url, completed: nil)
    }
    
    private func displayUserData(_ user: User) {
        self.setProfileImage(withUrlString: user.profileImageUrlString)
        self.usernameLabel.text = user.username
    }
}

extension StatsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / CGFloat(self.cellModels.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseId, for: indexPath) as! StatTableViewCell
        cell.viewModel = self.cellModels[indexPath.row]
        return cell
    }
}

extension StatsViewController: StatsPresenterDelegate {
    
    func statsPresenterDidProvideUserData(_ presenter: StatsPresenter, user: User, andStatCellViewModels viewModels: [StatTableViewCellViewModel]) {
        self.displayUserData(user)
        self.cellModels = viewModels
    }
}
