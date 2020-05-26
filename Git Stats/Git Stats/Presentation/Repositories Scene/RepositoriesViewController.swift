//
//  RepositoriesViewController.swift
//  Git Stats
//
//  Created by Jack Smith on 26/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import UIKit

class RepositoriesViewController: UITableViewController {
    
    // MARK: - Properties

    private var presenter: RepositoriesPresenterProtocol?
    
    private var cellViewModels = [RepositoryTableViewCellViewModel]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = RepositoriesPresenter(self)
        self.configureViews()
    }
    
    // MARK: - Methods
    
    private func configureViews() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.barTintColor = .aliceBlue
        self.navigationController?.navigationBar.tintColor = .morningBlue
        
        self.tableView.tableFooterView = UIView()
        
        let cellNib = UINib(nibName: RepositoryTableViewCell.className, bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: RepositoryTableViewCell.className)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RepositoryTableViewCell.height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.className, for: indexPath) as! RepositoryTableViewCell
        cell.viewModel = self.cellViewModels[indexPath.row]
        return cell
    }
}

extension RepositoriesViewController: RepositoriesPresenterDelegate {
    
    func repositoriesPresenterDidProvideViewModels(_ presenter: RepositoriesPresenter, viewModels: [RepositoryTableViewCellViewModel]) {
        self.cellViewModels = viewModels
    }
}

