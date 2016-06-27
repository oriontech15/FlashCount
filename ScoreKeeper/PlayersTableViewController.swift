//
//  PlayersTableViewController.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/10/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class PlayersTableViewController: UITableViewController, UpdateNavigationBarAppearanceDelegate, AddPlayerDelegate, DismissBlurDelegate, UIViewControllerPreviewingDelegate{
    
    @IBOutlet weak var addPlayerButton: CustomNumberButton!
    @IBOutlet weak var scoreButtonsStackView: UIStackView!
    @IBOutlet weak var editScoresButton: UIButton!
    @IBOutlet weak var scoreViewButton: UIButton!
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var toolbarView: UIView!
    @IBOutlet weak var toolbarSeperatorView: UIView!
    
    var isPlayersLabel: UILabel!
    
    var game: Game?
    
    var blurEffectView = UIVisualEffectView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForPreviewingWithDelegate(self, sourceView: scoreViewButton)
        
        isPlayersLabel = UILabel()
        self.view.addSubview(isPlayersLabel)
        isPlayersLabel.hidden = true
        
        AppearanceController.sharedController.navigationBarAppearanceDelegate = self
        
        AppearanceController.sharedController.loadTheme()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        toggleScoreViewButtonEnabled()
        self.tableView.reloadData()
        self.view.setNeedsDisplay()
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if let scoreViewController = storyboard?.instantiateViewControllerWithIdentifier("ScoreViewController") as? ScoreViewController {
        let buttonRect = self.scoreViewButton.frame
        previewingContext.sourceRect = buttonRect
        if let game = self.game {
            scoreViewController.game = game
        }
            return scoreViewController
        } else {
            return nil
        }
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        
        showViewController(viewControllerToCommit, sender: self)
    }
    
    func toggleScoreViewButtonEnabled() {
        if let game = self.game {
            if game.players!.count == 0 {
                isPlayersLabel.hidden = false
                self.view.bringSubviewToFront(isPlayersLabel)
                isPlayersLabel.frame = CGRectMake(self.view.frame.origin.x + 20, self.view.frame.origin.y + 20, self.view.frame.size.width - 40, 50)
                isPlayersLabel.textAlignment = .Center
                isPlayersLabel.textColor = .whiteColor()
                isPlayersLabel.text = "Currently no players"
                self.scoreButtonsStackView.hidden = true
            } else {
                self.scoreButtonsStackView.hidden = false
                isPlayersLabel.hidden = true
            }
        }
    }
    
    func updateNagivationBarAppearanceToThemeColor(color: UIColor, tintColor: UIColor, barStyle: UIBarStyle, editScoresImage: UIImage, trophyImage: UIImage) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : tintColor]
        self.navigationController?.navigationBar.barTintColor = color
        self.navigationController?.navigationBar.backgroundColor = .clearColor()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.barStyle = barStyle
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = tintColor

//        if AppearanceController.sharedController.theme == .Blue {
//            //            let imageView = UIImageView(frame: CGRectMake(0, self.view.frame.origin.y - 45, self.view.frame.width, UIScreen.mainScreen().bounds.height))
//            //            imageView.image = UIImage(named: "Background-Blue")
//            
//        } else {
//            //            let imageView = UIImageView(frame: CGRectMake(0, -45, self.view.frame.width, UIScreen.mainScreen().bounds.height))
//            //            imageView.image = UIImage(named: " Background-Red")
//            
//        }
        
        if AppearanceController.sharedController.theme == .Red {
            let view = UIView(frame: CGRectMake(0, -45, self.view.frame.width, UIScreen.mainScreen().bounds.height))
            view.backgroundColor = .themeDarkestGray()
            tableView.backgroundView = view
            if let game = self.game {
                gameTitleLabel.text = game.name
            }
            self.addPlayerButton.setImage(UIImage(named: "Add Player - White"), forState: .Normal)
            self.addPlayerButton.backgroundColor = .themeRedLight()
            self.gameTitleLabel.textColor = .whiteColor()
            self.toolbarView.backgroundColor = .themeDarkGray()
            self.toolbarSeperatorView.backgroundColor = .themeRedLight()
            self.addPlayerButton.setTitleColor(.whiteColor(), forState: .Normal)
        } else {
            let view = UIView(frame: CGRectMake(0, -45, self.view.frame.width, UIScreen.mainScreen().bounds.height))
            view.backgroundColor = .themeDarkestGray()
            tableView.backgroundView = view
            if let game = self.game {
                gameTitleLabel.text = game.name
            }
            self.addPlayerButton.setImage(UIImage(named: "ProfileBarButtonItem"), forState: .Normal)
            self.addPlayerButton.backgroundColor = .themeBlue()
            self.gameTitleLabel.textColor = .whiteColor()
            self.toolbarView.backgroundColor = .themeDarkGray()
            self.toolbarSeperatorView.backgroundColor = .themeBlue()
            self.addPlayerButton.setTitleColor(.themeDarkestGray(), forState: .Normal)
        }
        
        self.editScoresButton.setImage(editScoresImage, forState: .Normal)
        self.scoreViewButton.setImage(trophyImage, forState: .Normal)
    }
    
    @IBAction func createGameButtonTapped() {
        presentNewPlayerView()
    }
    
    func addPlayerButtonTapped() {
        presentNewPlayerView()
    }
    
    func presentNewPlayerView() {
        
        if let view = UIView.loadFromNibNamed("AddPlayersView") as? AddPlayerView
        {
            let blurEffect = UIBlurEffect(style: .Light)
            blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = (self.navigationController?.view.bounds)!
            
            view.alpha = 0.0
            let frame = CGRectMake(30, self.view.center.x - 150, UIScreen.mainScreen().bounds.width - 60, 390)
            view.frame = frame
            view.delegate = self
            view.game = self.game
            view.defaultFrame = frame
            view.layer.cornerRadius = 10
            self.navigationController?.view.addSubview(blurEffectView)
            self.navigationController?.view.addSubview(view)
            
            UIView.animateWithDuration(0.6, animations: {
                view.alpha = 1.0
            })
        }
    }
    
    func dismissBlur(cancelTapped: Bool)
    {
        UIView.animateWithDuration(0.3, animations: {
            self.blurEffectView.alpha = 0.0
        }) { (complete) in
            if complete
            {
                self.blurEffectView.removeFromSuperview()
                if !cancelTapped
                {
                    self.tableView.reloadData()
                    self.toggleScoreViewButtonEnabled()
                }
            }
        }
    }
    
    @IBAction func scoreViewButtonTapped() {
        self.performSegueWithIdentifier("toScoreView", sender: nil)
    }
    
    @IBAction func editScoresButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("toScoringView", sender: nil)
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if game?.players?.allObjects.count > 0 {
            if let players = game?.players?.allObjects as? [Player] {
                return players.count
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if game?.players?.allObjects.count > 0 {
            if let cell = tableView.dequeueReusableCellWithIdentifier("playerCell", forIndexPath: indexPath) as? PlayerTableViewCell {
                if let players = game?.players?.allObjects as? [Player] {
                    let sortedPlayers = players.sort({ $0.name < $1.name })
                    let player = sortedPlayers[indexPath.row]
                    if AppearanceController.sharedController.theme == .Red {
                        cell.updateWith(player, textColor: .whiteColor())
                        let selectedView = UIView()
                        selectedView.backgroundColor = .themeRedLight()
                        cell.selectedBackgroundView = selectedView
                    } else {
                        cell.updateWith(player, textColor: .whiteColor())
                        let selectedView = UIView()
                        selectedView.backgroundColor = .themeBlue()
                        cell.selectedBackgroundView = selectedView
                    }
                    
                    return cell
                } else {
                    return UITableViewCell()
                }
            } else {
                return UITableViewCell()
            }
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if indexPath.row != 0 {
                if let game = self.game, players = game.players?.allObjects as? [Player] {
                    let sortedPlayers = players.sort({$0.name < $1.name})
                    let player = sortedPlayers[indexPath.row]
                    tableView.beginUpdates()
                    GameController.sharedController.deletePlayerFromGame(player)
                    toggleScoreViewButtonEnabled()
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    tableView.endUpdates()
                }
            } else {
                if let game = self.game, players = game.players?.allObjects as? [Player] {
                    let sortedPlayers = players.sort({$0.name < $1.name})
                    let player = sortedPlayers[indexPath.row]
                    GameController.sharedController.deletePlayerFromGame(player)
                    toggleScoreViewButtonEnabled()
                    tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toScoringView", sender: nil)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Players"
        } else {
            return ""
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 3.0
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 3))
        let label = UILabel(frame: CGRectMake(30, 0, self.view.frame.width, 30))
        label.text = "This games players"
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        if AppearanceController.sharedController.theme == .Red {
            view.backgroundColor = .themeRedLight()
            label.textColor = .whiteColor()
        } else {
            view.backgroundColor = .themeBlue()
            label.textColor = .whiteColor()
        }
        return view
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toScoringView" {
            if let editScoreVC = segue.destinationViewController as? ScoreKeeperViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    editScoreVC.indexToStartFrom = indexPath.row
                }
                editScoreVC.game = self.game
            }
        } else if segue.identifier == "toScoreView" {
            if let scoreVC = segue.destinationViewController as? ScoreViewController {
                scoreVC.game = self.game
            }
        }
    }
}
