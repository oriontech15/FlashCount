//
//  PlayerCollectionViewCell.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/8/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var playerNameLabel: UILabel!

    func updateWith(name: String) {
        self.playerNameLabel.text = name
    }
}
