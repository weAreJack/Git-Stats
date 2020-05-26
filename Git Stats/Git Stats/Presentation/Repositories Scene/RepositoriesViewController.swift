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
    private let sceneTitle = "Repositories"
    
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
        self.configureNavigationBar()
        self.tableView.tableFooterView = UIView()
        
        let cellNib = UINib(nibName: RepositoryTableViewCell.className, bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: RepositoryTableViewCell.className)
    }
    
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.quicksandFont(ofSize: 18, andWeight: .bold), NSAttributedString.Key.foregroundColor: UIColor.morningBlue]
        self.navigationController?.navigationBar.backItem?.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.quicksandFont(ofSize: 16, andWeight: .regular)], for: UIControl.State.normal)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.barTintColor = .aliceBlue
        self.navigationController?.navigationBar.tintColor = .morningBlue
        self.navigationItem.title = self.sceneTitle
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

