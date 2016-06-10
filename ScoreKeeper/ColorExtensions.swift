//
//  UIColorExtensions.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 6/2/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static func themeBlue() -> UIColor {
        return UIColor(red: 0.275, green: 0.890, blue: 1.000, alpha: 1.00)
    }
    
    static func themeRed() -> UIColor {
        return UIColor(red: 1.000, green: 0.227, blue: 0.318, alpha: 1.00)
    }
    
    static func themeRedLight() -> UIColor {
        // 254 red, 82 green, 99 blue
        return UIColor(red: 0.996, green: 0.318, blue: 0.388, alpha: 1.00)
    }
    
    static func themeDarkestGray() -> UIColor {
        return UIColor(red: 0.184, green: 0.184, blue: 0.184, alpha: 1.00)
    }
    
    static func themeDarkGray() -> UIColor {
        return UIColor(red: 0.239, green: 0.239, blue: 0.239, alpha: 1.00)
    }
}