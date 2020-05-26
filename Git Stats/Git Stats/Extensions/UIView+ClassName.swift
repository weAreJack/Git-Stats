//
//  UIView+NibName.swift
//  Git Stats
//
//  Created by Jack Smith on 26/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import UIKit

extension UIView {
    
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}
