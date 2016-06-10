//
//  NoDataTableViewCell.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/26/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

protocol CreateGameDelegate {
    func createGameCellButtonTapped()
}

class NoDataTableViewCell: UITableViewCell, UpdateCreateGameButtonDelegate{

    @IBOutlet weak var createGameButton: UIButton!
    @IBOutlet weak var noDataLabel: UILabel!
    
    var delegate: CreateGameDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        AppearanceController.sharedController.updateCreateGameButtonDelegate = self
    }
    
    @IBAction func createGameButtonTapped(sender: AnyObject) {
        self.delegate?.createGameCellButtonTapped()
    }
    
    func updateCreateGameButton(color: UIColor, textColor: UIColor) {
        createGameButton.backgroundColor = color
        createGameButton.setTitleColor(textColor, forState: .Normal)
    }
}
