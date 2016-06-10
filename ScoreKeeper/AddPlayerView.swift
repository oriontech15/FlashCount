//
//  AddPlayerView.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 6/5/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class AddPlayerView: UIView, UITextFieldDelegate, TextFieldValueUpdatedDelegate {
    
    @IBOutlet weak var newPlayerTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    
    var blurredBackdropView = UIVisualEffectView()
    
    var defaultFrame: CGRect?
    
    var game: Game?
    
    var numberOfRows: Int = 1
    
    var playerNames: [String] = []
    
    var delegate: DismissBlurDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.newPlayerTableView.delegate = self
        self.newPlayerTableView.dataSource = self
        
        self.backgroundColor = .themeDarkGray()
        
        self.newPlayerTableView.registerNib(UINib(nibName: "NewPlayerCell", bundle: nil), forCellReuseIdentifier: "newPlayerCell")

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tap)
    }
    
    @IBAction func cancelButtonTapped() {
        removeView(true)
    }
    
    func removeView(cancelTapped: Bool)
    {
        UIView.animateWithDuration(0.3, animations: {
            self.delegate?.dismissBlur(cancelTapped)
            self.alpha = 0.0
        }) { (complete) in
            if complete
            {
                self.removeFromSuperview()
            }
        }
    }
    
    func addTextFieldValue(textField: UITextField, created: Bool) {
        self.playerNames.append(textField.text!)
        print(self.playerNames)
    }
    
    @IBAction func addButtonTapped() {
        createPlayers()
    }
    
    @IBAction func addPlayerButtonTapped(sender: AnyObject) {
        
        numberOfRows = numberOfRows + 1
        let newIndexPath = NSIndexPath(forItem: numberOfRows - 1, inSection: 0)
        self.newPlayerTableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)

        if numberOfRows >= 5 {
            let indexPath = NSIndexPath(forRow: numberOfRows - 1, inSection: 0)
            self.newPlayerTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
//            let offset = CGPointMake(0, newPlayerTableView.contentSize.height - newPlayerTableView.frame.size.height + 2)
//            self.newPlayerTableView.setContentOffset(offset, animated: true)
        }
    }
    
    func createPlayers()
    {
        self.endEditing(true)
        for index in 0..<self.numberOfRows {
            let cell = newPlayerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as? NewPlayerTableViewCell
            if let textField = cell?.playerNameTextField where textField.text != "", let game = self.game, name = textField.text {
                GameController.sharedController.addPlayerToGame(name, game: game)
            }
        }
        removeView(false)
    }
    
    
    
    func dismissKeyboard()
    {
        moveView(0, defaultFrame: true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        moveView(0, defaultFrame: true)
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        switch textField.tag
        {
        case 0:
            moveView(0, defaultFrame: false)
        case 1:
            moveView(50, defaultFrame: false)
        case 2:
            moveView(120, defaultFrame: false)
        default:
            moveView(0, defaultFrame: true)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.tag == 3
        {
            textView.text = ""
            moveView(220, defaultFrame: false)
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.tag == 3
        {
            textView.resignFirstResponder()
            moveView(0, defaultFrame: true)
        }
    }
    
    func moveView(up: CGFloat, defaultFrame: Bool)
    {
        if defaultFrame == true
        {
            if let frame = self.defaultFrame
            {
                UIView.animateWithDuration(0.3) {
                    self.frame = frame
                }
            }
        }
        else
        {
            if let frame = self.defaultFrame
            {
                UIView.animateWithDuration(0.3) {
                    self.frame = CGRectMake(frame.origin.x, frame.origin.y - up, frame.size.width, frame.size.height)
                }
            }
        }
    }
}

extension AddPlayerView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("newPlayerCell", forIndexPath: indexPath) as? NewPlayerTableViewCell
        cell?.playerNumberLabel.text = "\(indexPath.row + 1)"
        cell?.delegate = self
        cell?.playerNameTextField.becomeFirstResponder()
        
        return cell ?? UITableViewCell()
    }
}
