//
//  CustomNavBarEditPlayersButton.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/10/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class CustomNavBarEditPlayersButton: UIButton, UpdateCustomNavBarEditPlayersButtonUIDelegate {
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
        AppearanceController.sharedController.customNavBarEditPlayersButtonDelegate = self
        setupView()
    }
    
    func setupView() {
        self.backgroundColor = customBackgroundColor
        self.setTitleColor(customTextColor, forState: .Normal)
        self.layer.cornerRadius = 10
    }
    
    func updateCustomNavBarEditPlayersButton(backgroundColor: UIColor, textColor: UIColor) {
        self.customBackgroundColor = backgroundColor
        self.customTextColor = textColor
    }
}
