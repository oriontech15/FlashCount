//
//  PlayerTableViewCell.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/12/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateWith(player: Player, textColor: UIColor) {
        if let score = player.score {
            self.playerNameLabel.text = player.name
            self.playerNameLabel.textColor = textColor
            self.playerScoreLabel.text = "\(score)"
            self.playerScoreLabel.textColor = textColor
        }
    }
}
