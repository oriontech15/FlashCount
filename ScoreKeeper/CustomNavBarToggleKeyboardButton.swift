//
//  CustomNavBarToggleKeyboardButton.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/12/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class CustomNavBarToggleKeyboardButton: UIButton, UpdateCustomNavBarToggleKeyboardButtonUIDelegate {
        var customBackgroundColor: UIColor = .whiteColor() {
            didSet {
                setupView()
            }
        }
        
        var customTextColor: UIColor = .whiteColor() {
            didSet {
                setupView()
            }
        }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            AppearanceController.sharedController.customNavBarToggleKeyboardButtonDelegate = self
            setupView()
        }
        
        func setupView() {
            self.backgroundColor = customBackgroundColor
            self.setTitleColor(customTextColor, forState: .Normal)
            self.layer.cornerRadius = 10
        }
        
        func updateCustomNavBarToggleKeyboardButton(backgroundColor: UIColor, textColor: UIColor) {
            self.customBackgroundColor = backgroundColor
            self.customTextColor = textColor
        }
}
