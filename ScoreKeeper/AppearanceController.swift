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
    func updateCustomKeyboardTheme(textColor: UIColor, actionImage: UIImage, backImage: UIImage, nextPlayerImage: UIImage, previousPlayerImage: UIImage)
}

protocol UpdateNavigationBarAppearanceDelegate {
    func updateNagivationBarAppearanceToThemeColor(color: UIColor, tintColor: UIColor, barStyle: UIBarStyle, editScoresImage: UIImage, trophyImage: UIImage)
}

protocol ChangeUIDelegate {
    func changeAppearance()
}

protocol UpdateCreateGameButtonDelegate {
    func updateCreateGameButton(color: UIColor, textColor: UIColor)
}

protocol UpdateAddPlayerButtonDelegate {
    func updateAddPlayerButton(color: UIColor, textColor: UIColor)
}

enum Theme {
    case Blue
    case Red
}

class AppearanceController {
    
    var theme = Theme.Blue
    
    var playerCurrentIndex: Int = 0
    var playerFontSize: CGFloat = 18.0
    
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
    var updateCreateGameButtonDelegate: UpdateCreateGameButtonDelegate?
    var updateAddPlayerButtonDelegate: UpdateAddPlayerButtonDelegate?

    func toggleTheme() {
        if theme == .Blue {
            
            navigationBarAppearanceDelegate?.updateNagivationBarAppearanceToThemeColor(.themeDarkestGray(), tintColor: .whiteColor(), barStyle: .Black, editScoresImage: UIImage(named: "Edit Scores - Blue")!, trophyImage: UIImage(named: "Trophy - Blue")!)
            
            backgroundUpdateDelgate?.updateBackgroundImage(UIImage(named: "ScoreKeeperBackgroundNoColorBlur")!)
            
            plusButtonUIDelegate?.updatePlusButtonUI(UIImage(named: "Plus Button Filled")!)
            
            minusButtonUIDelegate?.updateMinusButtonUI(UIImage(named: "Minus Button Filled")!)
            
            customKeyboardThemeDelegate?.updateCustomKeyboardTheme(UIColor(patternImage: UIImage(named: "BlueNumberImage")!),
                                                                   actionImage: UIImage(named: "BlueActionButton")!,
                                                                   backImage: UIImage(named: "BlueBackSpace")!,
                                                                   nextPlayerImage: UIImage(named: "BlueNextPlayer")!,
                                                                   previousPlayerImage: UIImage(named: "BluePreviousPlayer")!)
            
            labelUIDelegate?.updateLabelUI(UIColor(patternImage: UIImage(named: "BlueLabelImage")!))
            
            customNavBarToggleThemeButtonDelegate?.updateCustomNavBarToggleThemeButton(UIColor(patternImage: UIImage(named: "BlueActionButton")!), textColor: .themeDarkestGray())
            
            customNavBarEditPlayersButtonDelegate?.updateCustomNavBarEditPlayersButton(UIColor(patternImage: UIImage(named: "BlueActionButton")!), textColor: .themeDarkestGray())
            
            customNavBarToggleKeyboardButtonDelegate?.updateCustomNavBarToggleKeyboardButton(UIColor(patternImage: UIImage(named: "BlueActionButton")!), textColor: .themeDarkestGray())
            
            updateCreateGameButtonDelegate?.updateCreateGameButton(.themeBlue(), textColor: .themeDarkestGray())
            
            updateAddPlayerButtonDelegate?.updateAddPlayerButton(.themeBlue(), textColor: .themeDarkestGray())
        } else {
            
            navigationBarAppearanceDelegate?.updateNagivationBarAppearanceToThemeColor(.themeDarkestGray(), tintColor: .whiteColor(), barStyle: .Black, editScoresImage: UIImage(named: "Edit Scores - Red")!, trophyImage: UIImage(named: "Trophy - Red")!)
            
            backgroundUpdateDelgate?.updateBackgroundImage(UIImage(named: "ScoreKeeperBackgroundNoColorBlur")!)
            
            plusButtonUIDelegate?.updatePlusButtonUI(UIImage(named: "Plus Button Red")!)
            
            minusButtonUIDelegate?.updateMinusButtonUI(UIImage(named: "Minus Button Red")!)
            
            customKeyboardThemeDelegate?.updateCustomKeyboardTheme(UIColor(patternImage: UIImage(named: "RedNumberImage")!),
                                                                   actionImage: UIImage(named: "RedActionButton")!,
                                                                   backImage: UIImage(named: "RedBackSpace")!,
                                                                   nextPlayerImage: UIImage(named: "RedNextPlayer")!,
                                                                   previousPlayerImage: UIImage(named: "RedPreviousPlayer")!)
            
            labelUIDelegate?.updateLabelUI(UIColor(patternImage: UIImage(named: "RedLabelImage")!))
            
            customNavBarToggleThemeButtonDelegate?.updateCustomNavBarToggleThemeButton(UIColor(patternImage: UIImage(named: "RedActionButton")!), textColor: .whiteColor())
            
            customNavBarEditPlayersButtonDelegate?.updateCustomNavBarEditPlayersButton(UIColor(patternImage: UIImage(named: "RedActionButton")!), textColor: .whiteColor())
            
            customNavBarToggleKeyboardButtonDelegate?.updateCustomNavBarToggleKeyboardButton(UIColor(patternImage: UIImage(named: "RedActionButton")!), textColor: .whiteColor())
            
            updateCreateGameButtonDelegate?.updateCreateGameButton(.themeRed(), textColor: .whiteColor())
            
            updateAddPlayerButtonDelegate?.updateAddPlayerButton(.themeRed(), textColor: .whiteColor())
        }
    }
    
    func loadTheme() {
        if theme == .Blue {
            
            navigationBarAppearanceDelegate?.updateNagivationBarAppearanceToThemeColor(.themeDarkestGray(), tintColor: .whiteColor(), barStyle: .Black, editScoresImage: UIImage(named: "Edit Scores - Blue")!, trophyImage: UIImage(named: "Trophy - Blue")!)
            
            backgroundUpdateDelgate?.updateBackgroundImage(UIImage(named: "ScoreKeeperBackgroundNoColorBlur")!)
            
            plusButtonUIDelegate?.updatePlusButtonUI(UIImage(named: "Plus Button Filled")!)
            
            minusButtonUIDelegate?.updateMinusButtonUI(UIImage(named: "Minus Button Filled")!)
            
            customKeyboardThemeDelegate?.updateCustomKeyboardTheme(UIColor(patternImage: UIImage(named: "BlueNumberImage")!), actionImage: UIImage(named: "BlueActionButton")!, backImage: UIImage(named: "BlueBackSpace")!, nextPlayerImage: UIImage(named: "BlueNextPlayer")!, previousPlayerImage: UIImage(named: "BluePreviousPlayer")!)
            
            labelUIDelegate?.updateLabelUI(UIColor(patternImage: UIImage(named: "BlueLabelImage")!))
            
            customNavBarEditPlayersButtonDelegate?.updateCustomNavBarEditPlayersButton(UIColor(patternImage: UIImage(named: "BlueNavButtonImage")!), textColor: .themeDarkestGray())
            
            customNavBarToggleKeyboardButtonDelegate?.updateCustomNavBarToggleKeyboardButton(UIColor(patternImage: UIImage(named: "BlueNavButtonImage")!), textColor: .themeDarkestGray())
            
            updateCreateGameButtonDelegate?.updateCreateGameButton(.themeBlue(), textColor: .themeDarkestGray())
            
            updateAddPlayerButtonDelegate?.updateAddPlayerButton(.themeBlue(), textColor: .themeDarkestGray())
        } else {
            
            navigationBarAppearanceDelegate?.updateNagivationBarAppearanceToThemeColor(.themeDarkestGray(), tintColor: .whiteColor(), barStyle: .Black, editScoresImage: UIImage(named: "Edit Scores - Red")!, trophyImage: UIImage(named: "Trophy - Red")!)
            
            backgroundUpdateDelgate?.updateBackgroundImage(UIImage(named: "ScoreKeeperBackgroundNoColorBlur")!)
            
            plusButtonUIDelegate?.updatePlusButtonUI(UIImage(named: "Plus Button Red")!)
            
            minusButtonUIDelegate?.updateMinusButtonUI(UIImage(named: "Minus Button Red")!)
            
            customKeyboardThemeDelegate?.updateCustomKeyboardTheme(UIColor(patternImage: UIImage(named: "RedNumberImage")!),
                                                                   actionImage: UIImage(named: "RedActionButton")!,
                                                                   backImage: UIImage(named: "RedBackSpace")!,
                                                                   nextPlayerImage: UIImage(named: "RedNextPlayer")!,
                                                                   previousPlayerImage: UIImage(named: "RedPreviousPlayer")!)
            
            labelUIDelegate?.updateLabelUI(UIColor(patternImage: UIImage(named: "RedLabelImage")!))
            
            customNavBarEditPlayersButtonDelegate?.updateCustomNavBarEditPlayersButton(UIColor(patternImage: UIImage(named: "RedNavButtonImage")!), textColor: .whiteColor())
            
            customNavBarToggleKeyboardButtonDelegate?.updateCustomNavBarToggleKeyboardButton(UIColor(patternImage: UIImage(named: "RedNavButtonImage")!), textColor: .whiteColor())
            
            updateCreateGameButtonDelegate?.updateCreateGameButton(.themeRed(), textColor: .whiteColor())
            
            updateAddPlayerButtonDelegate?.updateAddPlayerButton(.themeRed(), textColor: .whiteColor())
        }
    }
}