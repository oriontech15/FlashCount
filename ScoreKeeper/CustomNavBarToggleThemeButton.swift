//
//  CustomNavBarButton.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/10/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class CustomNavBarToggleThemeButton: UIButton, UpdateCustomNavBarToggleThemeButtonUIDelegate {

    var customBackgroundColor: UIColor = .whiteColor() {
        didSet {
            setupView()
        }
    }
    
    var customTextcolor: UIColor = .whiteColor() {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        AppearanceController.sharedController.customNavBarToggleThemeButtonDelegate = self
        setupView()
    }
    
    func setupView() {
        self.backgroundColor = customBackgroundColor
        self.setTitleColor(customTextcolor, forState: .Normal)
        self.layer.cornerRadius = 10
    }
    
    func updateCustomNavBarToggleThemeButton(backgroundColor: UIColor, textColor: UIColor) {
        self.customBackgroundColor = backgroundColor
        self.customTextcolor = textColor
    }
}
