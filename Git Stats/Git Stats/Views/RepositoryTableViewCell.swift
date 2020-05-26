//
//  RepositoryTableViewCell.swift
//  Git Stats
//
//  Created by Jack Smith on 26/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import UIKit

struct RepositoryTableViewCellViewModel {
    var name: String?
    var language: String?
    var stars: Int?
}

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    
    // MARK: - Properties
    
    static var height: CGFloat = 70
    
    var viewModel: RepositoryTableViewCellViewModel? {
        didSet {
            self.configureViews()
        }
    }
    
    // MARK: - Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .morningBlue
        self.selectionStyle = .none
    }
    
    // MARK: - Methods
    
    private func configureViews() {
        guard let viewModel = viewModel else {return}
        self.nameLabel.text = viewModel.name
        self.languageLabel.text = viewModel.language
        self.starsCountLabel.text = "\(viewModel.stars ?? 0)"
    }
}
