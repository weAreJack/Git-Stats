//
//  UIColor+AppColors.swift
//  Git Stats
//
//  Created by Jack Smith on 25/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import UIKit

extension UIColor {
    
    enum ColorNames: String {
        case aliceBlue = "Alice Blue"
        case babyPowder = "Baby Powder"
        case dimGray = "Dim Gray"
        case indianRed = "Indian Red"
        case morningBlue = "Morning Blue"
        case gold = "Gold"
    }
    
    static var aliceBlue: UIColor {
        return UIColor(named: ColorNames.aliceBlue.rawValue) ?? .clear
    }
    
    static var babyPowder: UIColor {
        return UIColor(named: ColorNames.babyPowder.rawValue) ?? .clear
    }
    
    static var dimGray: UIColor {
        return UIColor(named: ColorNames.dimGray.rawValue) ?? .clear
    }
    
    static var indianRed: UIColor {
        return UIColor(named: ColorNames.indianRed.rawValue) ?? .clear
    }
    
    static var morningBlue: UIColor {
        return UIColor(named: ColorNames.morningBlue.rawValue) ?? .clear
    }
    
    static var gold: UIColor {
        return UIColor(named: ColorNames.gold.rawValue) ?? .clear
    }
}
