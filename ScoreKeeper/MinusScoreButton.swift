//
//  MinusScoreButton.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/10/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class MinusScoreButton: UIButton, UpdateMinusButtonUIDelegate {

    var backgroundImage: UIImage = UIImage() {
        didSet {
            setupView()
        }
    }
    
    var image: UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        AppearanceController.sharedController.minusButtonUIDelegate = self
    }
    
    func setupView() {
        self.setBackgroundImage(backgroundImage, forState: .Normal)
    }
    
    func updateMinusButtonUI(minusImage: UIImage) {
            self.backgroundImage = minusImage
    }
}
