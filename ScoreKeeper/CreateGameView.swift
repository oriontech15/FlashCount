//
//  CreateGameView.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 6/4/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

protocol DismissBlurDelegate {
    func dismissBlur(cancelTapped: Bool)
}

class CreateGameView: UIView, UITextFieldDelegate, UITextViewDelegate
{
    @IBOutlet weak var gameTitleTextField: UITextField!
    @IBOutlet weak var lowHighSegmentedController: UISegmentedControl!
    @IBOutlet weak var infoLabel: UILabel!
    
    var blurredBackdropView = UIVisualEffectView()
    
    var defaultFrame: CGRect?
        
    var delegate: DismissBlurDelegate?
    
    override func awakeFromNib() {
        self.gameTitleTextField.becomeFirstResponder()
        defaultFrame = self.frame
        gameTitleTextField.delegate = self
        
        self.backgroundColor = .themeDarkGray()
        
        if AppearanceController.sharedController.theme == .Blue {
            lowHighSegmentedController.tintColor = .themeBlue()
        } else {
            lowHighSegmentedController.tintColor = .themeRedLight()
            let attributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            lowHighSegmentedController.setTitleTextAttributes(attributes, forState: .Normal)
            lowHighSegmentedController.setTitleTextAttributes(attributes, forState: .Selected)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tap)
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject)
    {
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
    
    @IBAction func createButtonTapped(sender: AnyObject)
    {
        createGame()
    }
    
    func createGame()
    {
        if let text = gameTitleTextField.text {
            GameController.sharedController.createGame(text, scoreType: lowHighSegmentedController.selectedSegmentIndex)
            removeView(false)
        }
    }
    
//    //Adds a VisualEffectView to the Date Picker View
//    func addBlurredBackgroundViewToView() -> UIVisualEffectView
//    {
//        let blurEffect = UIBlurEffect(style: .Dark)
//        let blurredBackdropView = UIVisualEffectView(effect: blurEffect)
//        
//        blurredBackdropView.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
//        blurredBackdropView.frame = self.superview!.bounds
//        self.superview?.addSubview(blurredBackdropView)
//        blurredBackdropView.alpha = 0.0
//        self.blurredBackdropView = blurredBackdropView
//        return blurredBackdropView
//    }
    
    func dismissKeyboard()
    {
        gameTitleTextField.resignFirstResponder()
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