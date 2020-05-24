//
//  UIFont+QuicksandFont.swift
//  Git Stats
//
//  Created by Jack Smith on 24/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import UIKit

extension UIFont {
    
    enum QuicksandFonttWeight: String {
        case light = "Quicksand-Light"
        case medium = "Quicksand-Light_Medium"
        case regular = "Quicksand-Light_Regular"
        case bold = "Quicksand-Light_Bold"
    }
    
    static func quicksandFont(ofSize size: CGFloat, andWeight weight: QuicksandFonttWeight) -> UIFont {
        guard let font = UIFont(name: weight.rawValue, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        
        return font
    }
}
