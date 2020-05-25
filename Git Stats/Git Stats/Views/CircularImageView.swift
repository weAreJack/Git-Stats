//
//  CircularImageView.swift
//  Git Stats
//
//  Created by Jack Smith on 25/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import UIKit

@IBDesignable
class CircularImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        self.sharedInit()
    }
    
    private func sharedInit() {
        self.refreshCorners(cornerRadius: self.frame.width / 2)
    }
    
    private func refreshCorners(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
    }
}
