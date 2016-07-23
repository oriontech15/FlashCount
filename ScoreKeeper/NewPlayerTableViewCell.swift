//
//  NewPlayerTableViewCell.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 6/5/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

protocol TextFieldValueUpdatedDelegate {
    func addTextFieldValue(textField: UITextField, created: Bool, cell: NewPlayerTableViewCell)
//    func checkNameInTextField(textField: UITextField, created: Bool, cell: NewPlayerTableViewCell)
}

class NewPlayerTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var playerNumberLabel: UILabel!
    @IBOutlet weak var playerNameTextField: UITextField!

    var delegate: TextFieldValueUpdatedDelegate?
    
    var created: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playerNameTextField.delegate = self
        playerNameTextField.keyboardAppearance = .Dark
        playerNameTextField.autocorrectionType = .No
        playerNameTextField.autocapitalizationType = .Words
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(textField: UITextField) {
        
        self.delegate?.addTextFieldValue(textField, created: created, cell: self)
        self.created = true
    }
}
