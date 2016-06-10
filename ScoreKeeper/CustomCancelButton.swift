//
//  CustomCancelButton.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 6/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class CustomCancelButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        
        if AppearanceController.sharedController.theme == .Blue {
            self.backgroundColor = .lightGrayColor()
            self.setTitleColor(.themeDarkestGray(), forState: .Normal)
        } else {
            self.backgroundColor = .lightGrayColor()
            self.setTitleColor(.whiteColor(), forState: .Normal)
        }
        
        self.layer.cornerRadius = self.frame.height / 2
    }

}
