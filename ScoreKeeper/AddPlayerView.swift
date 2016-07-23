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
        
        self.newPlayerTableView.registerNib(UINib(nibName: "PlayerNameCell", bundle: nil), forCellReuseIdentifier: "playerNameCell")
        
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
    
    func addTextFieldValue(textField: UITextField, created: Bool, cell: NewPlayerTableViewCell) {
        if let indexPath = newPlayerTableView.indexPathForCell(cell), newPlayerCell = newPlayerTableView.cellForRowAtIndexPath(indexPath) as? NewPlayerTableViewCell {
            if playerNames.count == newPlayerTableView.numberOfRowsInSection(0) {
                if playerNames[indexPath.row] != newPlayerCell.playerNameTextField.text {
                    if textField.text == ""
                    {
                        let randomFirstName = RandomNames.sharedNames.firstNames[Int(arc4random_uniform(UInt32(RandomNames.sharedNames.firstNames.count)))]
                        let randomLastName = RandomNames.sharedNames.lastNames[Int(arc4random_uniform(UInt32(RandomNames.sharedNames.lastNames.count)))]
                        print(RandomNames.sharedNames.firstNames.count)
                        print(RandomNames.sharedNames.lastNames.count)
                        self.playerNames.append(randomFirstName + " " + randomLastName)
                        textField.text = self.playerNames[indexPath.row]
                        print(self.playerNames)
                        
                    } else {
                        self.playerNames.removeAtIndex(indexPath.row)
                        self.playerNames.insert(textField.text!, atIndex: indexPath.row)
                        print(self.playerNames)
                    }
                } else {
                    print("They are equal")
                }
            } else {
                if textField.text == ""
                {
                    let randomFirstName = RandomNames.sharedNames.firstNames[Int(arc4random_uniform(UInt32(RandomNames.sharedNames.firstNames.count)))]
                    let randomLastName = RandomNames.sharedNames.lastNames[Int(arc4random_uniform(UInt32(RandomNames.sharedNames.lastNames.count)))]
                    print(RandomNames.sharedNames.firstNames.count)
                    print(RandomNames.sharedNames.lastNames.count)
                    self.playerNames.append(randomFirstName + " " + randomLastName)
                    textField.text = self.playerNames[indexPath.row]
                    print(self.playerNames)
                    
                } else {
                    let text = textField.text!
                    self.playerNames.append(text)
                    print(self.playerNames)
                }
            }
        }
    }
    
    @IBAction func addButtonTapped() {
        createPlayers()
    }
    
    @IBAction func addPlayerButtonTapped(sender: UIButton) {
        
        if numberOfRows != 5 {
            numberOfRows = numberOfRows + 1
            let newIndexPath = NSIndexPath(forItem: numberOfRows - 1, inSection: 0)
            self.newPlayerTableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
            
            let indexPath = NSIndexPath(forRow: numberOfRows - 1, inSection: 0)
            self.newPlayerTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
            
            if numberOfRows == 5 {
                sender.enabled = false
                sender.backgroundColor = .lightGrayColor()
            }
        }
    }
    
    func createPlayers()
    {
        self.endEditing(true)
        if self.playerNames.count > 0 {
            for index in 0..<self.numberOfRows {
                let indexPath = NSIndexPath(forRow: index, inSection: 0)
                if let newPlayerCell = newPlayerTableView.cellForRowAtIndexPath(indexPath) as? NewPlayerTableViewCell, game = self.game {
                    let textField = newPlayerCell.playerNameTextField
                    if textField.text != self.playerNames[index] {
                        self.playerNames.removeAtIndex(indexPath.row)
                        self.playerNames.insert(textField.text!, atIndex: indexPath.row)
                        print(playerNames)
                        let name = self.playerNames[index]
                        GameController.sharedController.addPlayerToGame(name, game: game)
                    } else {
                        print("They are equal")
                        let name = self.playerNames[index]
                        GameController.sharedController.addPlayerToGame(name, game: game)
                    }
                }
            }
        }
        removeView(false)
    }
    
    func dismissKeyboard()
    {
        moveView(0, defaultFrame: true)
        self.endEditing(true)
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
        switch section {
        case 1:
            return self.game?.players?.count ?? 0
        default:
            return self.numberOfRows
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("playerNameCell", forIndexPath: indexPath)
            if let player = self.game?.players?.allObjects[indexPath.row] as? Player {
                
                cell.textLabel?.text = player.name
                cell.textLabel?.textColor = .whiteColor()
            }
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("newPlayerCell", forIndexPath: indexPath) as? NewPlayerTableViewCell
            cell?.playerNumberLabel.text = "\(indexPath.row + 1)"
            cell?.delegate = self
            cell?.playerNameTextField.becomeFirstResponder()
            
            return cell ?? UITableViewCell()
        }
    }
}
