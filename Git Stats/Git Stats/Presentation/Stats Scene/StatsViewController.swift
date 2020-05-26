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
    
    private lazy var presenter: StatsPresenterProtocol = StatsPresenter(self)
    private let cellReuseId = "cell"
    
    private var repositories = [Repository]() {
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
        self.profileImageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
        self.profileImageView.sd_imageIndicator?.startAnimatingIndicator()
    }
    
    private func setProfileImage(withUrlString urlString: String) {
        let url = URL(string: urlString)
        self.profileImageView.sd_setImage(with: url, completed: nil)
    }
}

extension StatsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseId, for: indexPath)
        
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository.name
        cell.detailTextLabel?.text = "Language: \(repository.language), stars: \(repository.stars)."
        
        return cell
    }
}

extension StatsViewController: StatsPresenterDelegate {
    
    func statsPresenterDidProvideRepositoryData(_ presenter: StatsPresenter, repositories: [Repository]) {
        self.repositories = repositories
    }
    
    func statsPresenterDidProvideUserData(_ presenter: StatsPresenter, user: User) {
        self.setProfileImage(withUrlString: user.profileImageUrlString)
    }
}
