//
//  Extensions.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 6/2/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    class func loadFromNibNamed(nibNamed: String, bundle: NSBundle? = nil) -> UIView?
    {
        return UINib(nibName: nibNamed, bundle: bundle).instantiateWithOwner(nil, options: nil).first as? UIView
    }
}

extension NSDate {
    static func englishStringFromDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale.currentLocale()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        let dateString = formatter.stringFromDate(date)
        
        return dateString
    }
}