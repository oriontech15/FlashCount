//
//  CustomNavBarButton.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/10/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

@IBDesignable
class CustomNavBarToggleThemeButton: UIButton /* UpdateCustomNavBarToggleThemeButtonUIDelegate */ {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //AppearanceController.sharedController.customNavBarToggleThemeButtonDelegate = self
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        
        if AppearanceController.sharedController.theme == .Blue {
            self.backgroundColor = .themeBlue()
            self.setTitleColor(.themeDarkestGray(), forState: .Normal)
        } else {
            self.backgroundColor = .themeRedLight()
            self.setTitleColor(.whiteColor(), forState: .Normal)
        }
        
        self.layer.cornerRadius = self.frame.height / 2
    }
    
//    func updateCustomNavBarToggleThemeButton(backgroundColor: UIColor, textColor: UIColor) {
//        self.customBackgroundColor = backgroundColor
//        self.customTextcolor = textColor
//    }
}
