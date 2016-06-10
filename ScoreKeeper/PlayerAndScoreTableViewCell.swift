//
//  PlayerAndScoreTableViewCell.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 6/3/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class PlayerAndScoreTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateWithPlayer(player: Player, index: Int) {
        self.playerNameLabel.text = player.name
        
        if let score = player.score {
            self.playerScoreLabel.text = "\(score)"
        }
    }

}
