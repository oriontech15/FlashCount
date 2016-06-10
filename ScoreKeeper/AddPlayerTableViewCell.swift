//
//  AddPlayerTableViewCell.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/26/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

protocol AddPlayerDelegate {
    func addPlayerButtonTapped()
}

class AddPlayerTableViewCell: UITableViewCell{

    @IBOutlet weak var addPlayerButton: UIButton!
    
    var delegate: AddPlayerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func addPlayerButtonTapped() {
        self.delegate?.addPlayerButtonTapped()
    }
    
    func updateAddPlayerButton(color: UIColor, textColor: UIColor, image: UIImage) {
        addPlayerButton.backgroundColor = color
        addPlayerButton.setTitleColor(textColor, forState: .Normal)
        addPlayerButton.setImage(image, forState: .Normal)
    }
}
