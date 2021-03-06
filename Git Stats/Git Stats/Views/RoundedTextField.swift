//
//  RoundedTextField.swift
//  Git Stats
//
//  Created by Jack Smith on 25/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {
    
    @IBInspectable
    var textInset: CGFloat = 20
    
    @IBInspectable
    var shadowColor: UIColor = .gray {
        didSet {
            self.applyShadow(shadowColor: self.shadowColor)
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = .zero {
        didSet {
            self.refreshCorners(cornerRadius: self.cornerRadius)
        }
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: self.textInset , dy: .zero)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: self.textInset , dy: .zero)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: self.textInset, dy: .zero)
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
