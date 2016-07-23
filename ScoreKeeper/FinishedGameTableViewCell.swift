//
//  FinishedGameTableViewCell.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 7/21/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//
import UIKit

class FinishedGameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameDateLabel: UILabel!
    @IBOutlet weak var scoreTypeLabel: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    
    var lineColor: UIColor = .themeDarkestGray()
    
    override func drawRect(rect: CGRect)
    {
        UIView.animateWithDuration(10.0) { () -> Void in
            let bezier = UIBezierPath()
            bezier.moveToPoint(CGPoint(x: 0, y: (self.frame.height / 2)))
            bezier.addLineToPoint(CGPoint(x: self.center.x + 60, y: (self.frame.height / 2)))
            bezier.addLineToPoint(CGPoint(x: self.frame.width - 75, y: self.frame.height + 10))
            
            self.lineColor.setStroke()
            
            bezier.lineWidth = 1
            bezier.stroke()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateWith(name: String, date: String, playerCount: Int, game: Game, winner: String, score: Int, scoreType: String, textColor: UIColor) {
        //self.gamePlayersLabel.layer.cornerRadius = self.gamePlayersLabel.frame.height / 2
        //self.gamePlayersLabel.layer.masksToBounds = true
        
        self.gameNameLabel.text = "\(winner) Won \(name)!"
        self.gameDateLabel.text = date
        
        if playerCount > 1 || playerCount == 0 {
            //self.gamePlayersLabel.text = "\(playerCount) Players"
        } else if playerCount == 1 {
            //self.gamePlayersLabel.text = "\(playerCount) Player"
        }
        
        self.scoreTypeLabel.text = scoreType
        
        if AppearanceController.sharedController.theme == .Blue {
            //self.gamePlayersLabel.textColor = .themeBlue()
        } else {
            //self.gamePlayersLabel.textColor = .themeRedLight()
        }
        
//        self.winnerLabel.textColor = textColor
        self.gameDateLabel.textColor = textColor
        self.gameNameLabel.textColor = textColor
    }
}
