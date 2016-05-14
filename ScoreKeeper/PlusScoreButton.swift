//
//  ScoreButton.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/8/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class PlusScoreButton: UIButton, UpdatePlusButtonUIDelegate {

    var backgroundImage: UIImage = UIImage() {
        didSet {
            setupView()
        }
    }
    var image: UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        AppearanceController.sharedController.plusButtonUIDelegate = self
    }
    
    func setupView() {
        self.setBackgroundImage(backgroundImage, forState: .Normal)
    }
    
    func updatePlusButtonUI(plusImage: UIImage) {
            self.backgroundImage = plusImage
    }
}
