//
//  StatTableViewCell.swift
//  Git Stats
//
//  Created by Jack Smith on 26/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import UIKit

struct StatTableViewCellViewModel {
    var title: String?
    var detailText: String?
    var icon: UIImage?
    var showsChevron: Bool = false
}

class StatTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var iconView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!
    @IBOutlet private weak var chevronImageView: UIImageView!
    
    // MARK: - Properties
    
    var viewModel: StatTableViewCellViewModel? {
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
        self.iconView.image = viewModel.icon
        self.titleLabel.text = viewModel.title
        self.detailLabel.text = viewModel.detailText
        self.chevronImageView.isHidden = !viewModel.showsChevron
    }
}
