//
//  ViewController.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/8/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class ScoreKeeperViewController: UIViewController, UpdateBackgroundImageDelegate, UpdateCustomKeyboardThemeDelegate {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var toggleThemeButton: UIButton!
    @IBOutlet weak var keyboardButton: UIButton!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var oneHundredToggleButton: UIButton!
    @IBOutlet weak var tenToggleButton: UIButton!
    @IBOutlet weak var oneToggleButton: UIButton!
    @IBOutlet weak var keyboardView: UIView!
    @IBOutlet weak var plusMinusStackView: UIStackView!
    @IBOutlet weak var numberToUpdateWithLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var seperatorViewKeyboard: UIView!
    
    var numberString: String = ""
    var number: Int = 0
    var isInMiddleOfNumber: Bool = false
    var players: [Player] = []
    var game: Game?
    var currentIndex = 0
    var scoreIncrement = 1
    var selectedTag = 1
    var windowA = true
    
    var keyboardButtons: [UIButton] = []
    
    @IBOutlet weak var counterButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var keyboardViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var keyboardHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //backgroundImageView.hidden = true
        
        keyboardButtons = [zeroButton, oneButton, twoButton, threeButton, fourButton, fiveButton, sixButton, sevenButton, eightButton, nineButton, minusButton, plusButton]
        
        if let game = game, players = game.players?.allObjects as? [Player] {
            self.players = players.sort({$0.name < $1.name})
        }
        
        if UIScreen.mainScreen().nativeBounds.height == 960 {
            for button in keyboardButtons {
                button.layer.cornerRadius = 10
            }
            keyboardViewHeightConstraint.constant = 235
            keyboardHeightConstraint.constant = 170
            counterButtonHeightConstraint.constant = 180
        }
        
        if UIScreen.mainScreen().nativeBounds.height == 1136 {
            counterButtonHeightConstraint.constant = 220
        }
        
        AppearanceController.sharedController.backgroundUpdateDelgate = self
        AppearanceController.sharedController.customKeyboardThemeDelegate = self
        AppearanceController.sharedController.loadTheme()
        updateUIForScoreIncrementButtons(selectedTag)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func changeAppearance() {
        if AppearanceController.sharedController.theme == .Blue {
            AppearanceController.sharedController.theme = .Red
            AppearanceController.sharedController.toggleTheme()
            updateUIForScoreIncrementButtons(selectedTag)
            toggleThemeButton.setTitle("Blue", forState: .Normal)
        } else {
            AppearanceController.sharedController.theme = .Blue
            AppearanceController.sharedController.toggleTheme()
            updateUIForScoreIncrementButtons(selectedTag)
            toggleThemeButton.setTitle("Red", forState: .Normal)
        }
    }
    
    @IBAction func switchKeyboardButtonTapped() {
        CATransaction.flush()
        
        let transitionKeyboardOptions: UIViewAnimationOptions = [.TransitionFlipFromBottom, .ShowHideTransitionViews]
        let transitionStackViewOptions: UIViewAnimationOptions = [.TransitionFlipFromTop, .ShowHideTransitionViews]
        
        if windowA {
            UIView.transitionFromView(keyboardView, toView: plusMinusStackView, duration: 1.0, options: transitionKeyboardOptions, completion: { (completed) in
                if completed {
                }
            })
            self.keyboardButton.setTitle("Number Pad", forState: .Normal)
            self.windowA = false
        } else {
            UIView.transitionFromView(plusMinusStackView, toView: keyboardView, duration: 1.0, options: transitionStackViewOptions, completion: { (completed) in
                if completed {
                }
            })
            self.keyboardButton.setTitle("- Counter +", forState: .Normal)
            self.windowA = true
        }
    }
    
    @IBAction func keyboardButtonsTapped(sender: UIButton) {
        switch sender.tag {
        case 10:
            isInMiddleOfNumber = true
            minusButton.enabled = true
            plusButton.enabled = true
            updateNumber("0", plus: false)
            break
        case 11:
            isInMiddleOfNumber = true
            minusButton.enabled = true
            plusButton.enabled = true
            updateNumber("1", plus: false)
            break
        case 12:
            isInMiddleOfNumber = true
            minusButton.enabled = true
            plusButton.enabled = true
            updateNumber("2", plus: false)
            break
        case 13:
            isInMiddleOfNumber = true
            minusButton.enabled = true
            plusButton.enabled = true
            updateNumber("3", plus: false)
            break
        case 14:
            isInMiddleOfNumber = true
            minusButton.enabled = true
            plusButton.enabled = true
            updateNumber("4", plus: false)
            break
        case 15:
            isInMiddleOfNumber = true
            minusButton.enabled = true
            plusButton.enabled = true
            updateNumber("5", plus:  false)
            break
        case 16:
            isInMiddleOfNumber = true
            minusButton.enabled = true
            plusButton.enabled = true
            updateNumber("6", plus: false)
            break
        case 17:
            isInMiddleOfNumber = true
            minusButton.enabled = true
            plusButton.enabled = true
            updateNumber("7", plus: false)
            break
        case 18:
            isInMiddleOfNumber = true
            minusButton.enabled = true
            plusButton.enabled = true
            updateNumber("8", plus: false)
            break
        case 19:
            isInMiddleOfNumber = true
            minusButton.enabled = true
            plusButton.enabled = true
            updateNumber("9", plus: false)
            break
        case 20:
            isInMiddleOfNumber = false
            minusButton.enabled = false
            plusButton.enabled = false
            updateNumber("0", plus: true)
            break
        case 21:
            isInMiddleOfNumber = false
            minusButton.enabled = false
            plusButton.enabled = false
            updateNumber("0", plus: false)
            break
        default:
            break
        }
    }
    
    func updateNumber(number: String, plus: Bool) {
        if isInMiddleOfNumber {
            self.numberString = self.numberString.stringByAppendingString(number)
            self.numberToUpdateWithLabel.text = self.numberString
        } else {
            if let numberToUpdateWith = Int(self.numberString)
            {
                self.number = numberToUpdateWith
                self.numberToUpdateWithLabel.text = number
                if plus {
                    if let score = players[currentIndex].score?.integerValue {
                        let newScore = score + self.number
                        players[currentIndex].score = NSNumber(integer: newScore)
                        playerScoreLabel.text = "\(players[currentIndex].score!)"
                        GameController.sharedController.save()
                    }
                } else {
                    if let score = players[currentIndex].score?.integerValue {
                        let newScore = score - self.number
                        players[currentIndex].score = NSNumber(integer: newScore)
                        playerScoreLabel.text = "\(players[currentIndex].score!)"
                        GameController.sharedController.save()
                    }
                }
            }
            numberString = ""
        }
    }
    
    @IBAction func editPlayersButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func updateCustomKeyboardTheme(textColor: UIColor, actionImage: UIImage) {
        self.zeroButton.setTitleColor(textColor, forState: .Normal)
        self.oneButton.setTitleColor(textColor, forState: .Normal)
        self.twoButton.setTitleColor(textColor, forState: .Normal)
        self.threeButton.setTitleColor(textColor, forState: .Normal)
        self.fourButton.setTitleColor(textColor, forState: .Normal)
        self.fiveButton.setTitleColor(textColor, forState: .Normal)
        self.sixButton.setTitleColor(textColor, forState: .Normal)
        self.sevenButton.setTitleColor(textColor, forState: .Normal)
        self.eightButton.setTitleColor(textColor, forState: .Normal)
        self.nineButton.setTitleColor(textColor, forState: .Normal)
        self.minusButton.setBackgroundImage(actionImage, forState: .Normal)
        self.plusButton.setBackgroundImage(actionImage, forState: .Normal)
        self.seperatorViewKeyboard.backgroundColor = textColor
    }
    
    func updateBackgroundImage(backgroundImage: UIImage) {
        self.backgroundImageView.image = backgroundImage
    }
    
    func toggleScoreIncrementWithButtonTag(sender: UIButton) {
        
        switch sender.tag {
        case 1:
            self.scoreIncrement = 1
            selectedTag = sender.tag
            updateUIForScoreIncrementButtons(sender.tag)
        case 10:
            self.scoreIncrement = 10
            selectedTag = sender.tag
            updateUIForScoreIncrementButtons(sender.tag)
        case 100:
            self.scoreIncrement = 100
            selectedTag = sender.tag
            updateUIForScoreIncrementButtons(sender.tag)
        default:
            self.scoreIncrement = 1
            selectedTag = sender.tag
            updateUIForScoreIncrementButtons(sender.tag)
        }
    }
    
    func updateUIForScoreIncrementButtons(tag: Int) {
        if AppearanceController.sharedController.theme == .Blue {
            switch tag {
            case 1:
                oneToggleButton.setBackgroundImage(UIImage(named: "SelectedScoreToggle"), forState: .Normal)
                tenToggleButton.setBackgroundImage(UIImage(named: "UnselectedScoreToggle"), forState: .Normal)
                oneHundredToggleButton.setBackgroundImage(UIImage(named: "UnselectedScoreToggle"), forState: .Normal)
            case 10:
                oneToggleButton.setBackgroundImage(UIImage(named: "UnselectedScoreToggle"), forState: .Normal)
                tenToggleButton.setBackgroundImage(UIImage(named: "SelectedScoreToggle"), forState: .Normal)
                oneHundredToggleButton.setBackgroundImage(UIImage(named: "UnselectedScoreToggle"), forState: .Normal)
            case 100:
                oneToggleButton.setBackgroundImage(UIImage(named: "UnselectedScoreToggle"), forState: .Normal)
                tenToggleButton.setBackgroundImage(UIImage(named: "UnselectedScoreToggle"), forState: .Normal)
                oneHundredToggleButton.setBackgroundImage(UIImage(named: "SelectedScoreToggle"), forState: .Normal)
            default:
                oneToggleButton.setBackgroundImage(UIImage(named: "SelectedScoreToggle"), forState: .Normal)
                tenToggleButton.setBackgroundImage(UIImage(named: "UnselectedScoreToggle"), forState: .Normal)
                oneHundredToggleButton.setBackgroundImage(UIImage(named: "UnselectedScoreToggle"), forState: .Normal)
            }
        } else {
            switch tag {
            case 1:
                oneToggleButton.setBackgroundImage(UIImage(named: "SelectedScoreToggleRed"), forState: .Normal)
                tenToggleButton.setBackgroundImage(UIImage(named: "UnselectedScoreToggle"), forState: .Normal)
                oneHundredToggleButton.setBackgroundImage(UIImage(named: "UnselectedScoreToggle"), forState: .Normal)
            case 10:
                oneToggleButton.setBackgroundImage(UIImage(named: "UnselectedScoreToggle"), forState: .Normal)
                tenToggleButton.setBackgroundImage(UIImage(named: "SelectedScoreToggleRed"), forState: .Normal)
                oneHundredToggleButton.setBackgroundImage(UIImage(named: "UnselectedScoreToggle"), forState: .Normal)
            case 100:
                oneToggleButton.setBackgroundImage(UIImage(named: "UnselectedScoreToggle"), forState: .Normal)
                tenToggleButton.setBackgroundImage(UIImage(named: "UnselectedScoreToggle"), forState: .Normal)
                oneHundredToggleButton.setBackgroundImage(UIImage(named: "SelectedScoreToggleRed"), forState: .Normal)
            default:
                oneToggleButton.setBackgroundImage(UIImage(named: "SelectedScoreToggleRed"), forState: .Normal)
                tenToggleButton.setBackgroundImage(UIImage(named: "UnselectedScoreToggle"), forState: .Normal)
                oneHundredToggleButton.setBackgroundImage(UIImage(named: "UnselectedScoreToggle"), forState: .Normal)
            }
        }
    }
    
    @IBAction func scoreIncrementButtonTapped(sender: UIButton) {
        toggleScoreIncrementWithButtonTag(sender)
    }
    
    @IBAction func plusButtonTapped() {
        if let score = players[currentIndex].score?.integerValue {
            let newScore = score + scoreIncrement
            players[currentIndex].score = NSNumber(integer: newScore)
            playerScoreLabel.text = "\(players[currentIndex].score!)"
            GameController.sharedController.save()
        }
    }
    
    @IBAction func minusButtonTapped() {
        if let score = players[currentIndex].score?.integerValue {
            let newScore = score - scoreIncrement
            players[currentIndex].score = NSNumber(integer: newScore)
            playerScoreLabel.text = "\(players[currentIndex].score!)"
            GameController.sharedController.save()
        }
    }
}

extension ScoreKeeperViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.players.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("playerNameCell", forIndexPath: indexPath) as? PlayerCollectionViewCell
        
        currentIndex = indexPath.item
        let player = players[indexPath.item]
        cell?.updateWith(player.name)
        if let score = player.score {
            playerScoreLabel.text = "\(score)"
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(UIScreen.mainScreen().bounds.width - 40, collectionView.frame.height)
    }
}

