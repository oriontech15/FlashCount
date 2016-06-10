//
//  CustomDateLabel.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 6/2/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

@IBDesignable
class CustomDateLabel: UILabel {

    @IBInspectable var leftInset: CGFloat = 0.0
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    override func drawTextInRect(rect: CGRect) {
        let insets = UIEdgeInsets(top: 0.0, left: leftInset, bottom: 0.0, right: 0.0)
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }

}
