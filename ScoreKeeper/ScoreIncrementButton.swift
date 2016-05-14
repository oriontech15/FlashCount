//
//  ScoreIncrementButton.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/10/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class ScoreIncrementButton: UIButton {

    var backgroundImage: UIImage = UIImage() {
        didSet {
            setupView()
        }
    }
    var buttonSelected: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func setupView() {
        self.setBackgroundImage(backgroundImage ?? UIImage(named: "UnSelectedScoreToggle"), forState: .Normal)
    }
    
    func updateScoreIncrementButtonUI(backgroundImage: UIImage) {
        self.backgroundImage = backgroundImage
    }
}
