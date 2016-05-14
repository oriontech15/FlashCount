//
//  AppearanceController.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/10/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import UIKit

protocol UpdatePlusButtonUIDelegate {
    func updatePlusButtonUI(plusImage: UIImage)
}

protocol UpdateMinusButtonUIDelegate {
    func updateMinusButtonUI(minusImage: UIImage)
}

protocol UpdateLabelUIDelegate {
    func updateLabelUI(textColor: UIColor)
}

protocol UpdateBackgroundImageDelegate {
    func updateBackgroundImage(backgroundImage: UIImage)
}

protocol UpdateCustomNavBarToggleThemeButtonUIDelegate {
    func updateCustomNavBarToggleThemeButton(backgroundColor: UIColor, textColor: UIColor)
}

protocol UpdateCustomNavBarEditPlayersButtonUIDelegate {
    func updateCustomNavBarEditPlayersButton(backgroundColor: UIColor, textColor: UIColor)
}

protocol UpdateCustomNavBarToggleKeyboardButtonUIDelegate {
    func updateCustomNavBarToggleKeyboardButton(backgroundColor: UIColor, textColor: UIColor)
}

protocol UpdateCustomKeyboardThemeDelegate {
    func updateCustomKeyboardTheme(textColor: UIColor, actionImage: UIImage)
}

protocol UpdateNavigationBarAppearanceDelegate {
    func updateNagivationBarAppearanceToThemeColor(color: UIColor, tintColor: UIColor, barStyle: UIBarStyle)
}

protocol ChangeUIDelegate {
    func changeAppearance()
}

enum Theme {
    case Blue
    case Red
}

class AppearanceController {
    
    var theme = Theme.Blue
    
    static let sharedController = AppearanceController()
    
    var plusButtonUIDelegate: UpdatePlusButtonUIDelegate?
    var minusButtonUIDelegate: UpdateMinusButtonUIDelegate?
    var labelUIDelegate: UpdateLabelUIDelegate?
    var backgroundUpdateDelgate: UpdateBackgroundImageDelegate?
    var customNavBarToggleThemeButtonDelegate: UpdateCustomNavBarToggleThemeButtonUIDelegate?
    var navigationBarAppearanceDelegate: UpdateNavigationBarAppearanceDelegate?
    var customNavBarEditPlayersButtonDelegate: UpdateCustomNavBarEditPlayersButtonUIDelegate?
    var customNavBarToggleKeyboardButtonDelegate: UpdateCustomNavBarToggleKeyboardButtonUIDelegate?
    var customKeyboardThemeDelegate: UpdateCustomKeyboardThemeDelegate?
    var changeUIDelegate: ChangeUIDelegate?

    func toggleTheme() {
        if theme == .Blue {
            
            navigationBarAppearanceDelegate?.updateNagivationBarAppearanceToThemeColor(UIColor(red: 0.275, green: 0.890, blue: 1.000, alpha: 1.00), tintColor: UIColor(red: 0.184, green: 0.184, blue: 0.184, alpha: 1.00), barStyle: .Default)
            backgroundUpdateDelgate?.updateBackgroundImage(UIImage(named: "ScoreKeeperBackgroundNoColorBlur")!)
            plusButtonUIDelegate?.updatePlusButtonUI(UIImage(named: "Plus Button Filled")!)
            minusButtonUIDelegate?.updateMinusButtonUI(UIImage(named: "Minus Button Filled")!)
            customKeyboardThemeDelegate?.updateCustomKeyboardTheme(UIColor(patternImage: UIImage(named: "BlueNumberImage")!), actionImage: UIImage(named: "BlueActionButton")!)
            labelUIDelegate?.updateLabelUI(UIColor(patternImage: UIImage(named: "BlueLabelImage")!))
            customNavBarToggleThemeButtonDelegate?.updateCustomNavBarToggleThemeButton(UIColor(patternImage: UIImage(named: "BlueActionButton")!), textColor: UIColor(red: 0.184, green: 0.184, blue: 0.184, alpha: 1.00))
            customNavBarEditPlayersButtonDelegate?.updateCustomNavBarEditPlayersButton(UIColor(patternImage: UIImage(named: "BlueActionButton")!), textColor: UIColor(red: 0.184, green: 0.184, blue: 0.184, alpha: 1.00))
            customNavBarToggleKeyboardButtonDelegate?.updateCustomNavBarToggleKeyboardButton(UIColor(patternImage: UIImage(named: "BlueActionButton")!), textColor: UIColor(red: 0.184, green: 0.184, blue: 0.184, alpha: 1.00))
            
        } else {
            
            navigationBarAppearanceDelegate?.updateNagivationBarAppearanceToThemeColor(UIColor(red: 1.000, green: 0.227, blue: 0.318, alpha: 1.00), tintColor: .whiteColor(), barStyle: .BlackTranslucent)
            backgroundUpdateDelgate?.updateBackgroundImage(UIImage(named: "ScoreKeeperBackgroundNoColorBlur")!)
            plusButtonUIDelegate?.updatePlusButtonUI(UIImage(named: "Plus Button Red")!)
            minusButtonUIDelegate?.updateMinusButtonUI(UIImage(named: "Minus Button Red")!)
            customKeyboardThemeDelegate?.updateCustomKeyboardTheme(UIColor(patternImage: UIImage(named: "RedNumberImage")!), actionImage: UIImage(named: "RedActionButton")!)
            labelUIDelegate?.updateLabelUI(UIColor(patternImage: UIImage(named: "RedLabelImage")!))
            customNavBarToggleThemeButtonDelegate?.updateCustomNavBarToggleThemeButton(UIColor(patternImage: UIImage(named: "RedActionButton")!), textColor: .whiteColor())
            customNavBarEditPlayersButtonDelegate?.updateCustomNavBarEditPlayersButton(UIColor(patternImage: UIImage(named: "RedActionButton")!), textColor: .whiteColor())
            customNavBarToggleKeyboardButtonDelegate?.updateCustomNavBarToggleKeyboardButton(UIColor(patternImage: UIImage(named: "RedActionButton")!), textColor: .whiteColor())
        }
    }
    
    func loadTheme() {
        if theme == .Blue {
            
            navigationBarAppearanceDelegate?.updateNagivationBarAppearanceToThemeColor(UIColor(red: 0.275, green: 0.890, blue: 1.000, alpha: 1.00), tintColor: UIColor(red: 0.184, green: 0.184, blue: 0.184, alpha: 1.00), barStyle: .Default)
            backgroundUpdateDelgate?.updateBackgroundImage(UIImage(named: "ScoreKeeperBackgroundNoColorBlur")!)
            plusButtonUIDelegate?.updatePlusButtonUI(UIImage(named: "Plus Button Filled")!)
            minusButtonUIDelegate?.updateMinusButtonUI(UIImage(named: "Minus Button Filled")!)
            customKeyboardThemeDelegate?.updateCustomKeyboardTheme(UIColor(patternImage: UIImage(named: "BlueNumberImage")!), actionImage: UIImage(named: "BlueActionButton")!)
            labelUIDelegate?.updateLabelUI(UIColor(patternImage: UIImage(named: "BlueLabelImage")!))
            customNavBarEditPlayersButtonDelegate?.updateCustomNavBarEditPlayersButton(UIColor(patternImage: UIImage(named: "BlueNavButtonImage")!), textColor: UIColor(red: 0.184, green: 0.184, blue: 0.184, alpha: 1.00))
            customNavBarToggleKeyboardButtonDelegate?.updateCustomNavBarToggleKeyboardButton(UIColor(patternImage: UIImage(named: "BlueNavButtonImage")!), textColor: UIColor(red: 0.184, green: 0.184, blue: 0.184, alpha: 1.00))
            
        } else {
            
            navigationBarAppearanceDelegate?.updateNagivationBarAppearanceToThemeColor(UIColor(red: 1.000, green: 0.227, blue: 0.318, alpha: 1.00), tintColor: .whiteColor(), barStyle: .BlackTranslucent)
            backgroundUpdateDelgate?.updateBackgroundImage(UIImage(named: "ScoreKeeperBackgroundNoColorBlur")!)
            plusButtonUIDelegate?.updatePlusButtonUI(UIImage(named: "Plus Button Red")!)
            minusButtonUIDelegate?.updateMinusButtonUI(UIImage(named: "Minus Button Red")!)
            customKeyboardThemeDelegate?.updateCustomKeyboardTheme(UIColor(patternImage: UIImage(named: "RedNumberImage")!), actionImage: UIImage(named: "RedActionButton")!)
            labelUIDelegate?.updateLabelUI(UIColor(patternImage: UIImage(named: "RedLabelImage")!))
            customNavBarEditPlayersButtonDelegate?.updateCustomNavBarEditPlayersButton(UIColor(patternImage: UIImage(named: "RedNavButtonImage")!), textColor: .whiteColor())
            customNavBarToggleKeyboardButtonDelegate?.updateCustomNavBarToggleKeyboardButton(UIColor(patternImage: UIImage(named: "RedNavButtonImage")!), textColor: .whiteColor())
        }
    }
}