//
//  ScoreLabel.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/8/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

@IBDesignable
class ScoreLabel: UILabel, UpdateLabelUIDelegate {

    var labelTextColor: UIColor = .whiteColor() {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        AppearanceController.sharedController.labelUIDelegate = self
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

    func setupView() {
        self.textColor = labelTextColor
    }
    
    func updateLabelUI(textColor: UIColor) {
        self.labelTextColor = textColor
    }
}
