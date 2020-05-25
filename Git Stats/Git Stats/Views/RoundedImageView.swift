//
//  RoundedImageView.swift
//  Git Stats
//
//  Created by Jack Smith on 25/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import UIKit

@IBDesignable
class CircularImageView: UIImageView {
    
    @IBInspectable
    var shadowColor: UIColor = .gray {
        didSet {
            self.applyShadow(shadowColor: self.shadowColor)
        }
    }
    
    private let shadowRadius: CGFloat = 5
    private let shadowOpacity: Float = 0.5
    
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
    
    override func didMoveToSuperview() {
        self.refreshCorners(cornerRadius: self.frame.height / 2)
    }
    
    private func sharedInit() {
        self.refreshCorners(cornerRadius: self.frame.height / 2)
        self.applyShadow(shadowColor: .gray)
    }
    
    private func refreshCorners(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
    }
    
    private func applyShadow(shadowColor: UIColor) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = .init(width: CGFloat.zero, height: CGFloat.zero)
        self.layer.shadowRadius = self.shadowRadius
        self.layer.shadowOpacity = self.shadowOpacity
    }
}

