//
//  GamesTableViewController.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/10/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class GamesTableViewController: UITableViewController, UpdateNavigationBarAppearanceDelegate, CreateGameDelegate, DismissBlurDelegate {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bucketBarButton: UIBarButtonItem!
    @IBOutlet weak var addGameBarButton: UIBarButtonItem!
    @IBOutlet weak var gameFinishedToggle: UISegmentedControl!
    
    var blurEffectView = UIVisualEffectView()
    
    var game: Game?
    var finished: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        self.tableView.contentInset = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 40)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.tableView.reloadData()
        AppearanceController.sharedController.navigationBarAppearanceDelegate = self
        if AppearanceController.sharedController.theme == .Blue {
            bucketBarButton.image = UIImage(named: "BluePaintBucket")?.imageWithRenderingMode(.AlwaysOriginal)
        } else {
            bucketBarButton.image = UIImage(named: "RedPaintBucket")?.imageWithRenderingMode(.AlwaysOriginal)
        }
        AppearanceController.sharedController.loadTheme()
    }
    
    @IBAction func gameFinishedSegue(segue: UIStoryboardSegue) {
        self.tableView.reloadData()
    }
    
    @IBAction func gameFinisedToggled(sender: UISegmentedControl) {
        self.finished = Bool(sender.selectedSegmentIndex)
        
        self.tableView.reloadData()
    }
    
    @IBAction func changeThemeButtonTapped() {
        if AppearanceController.sharedController.theme == .Blue {
            AppearanceController.sharedController.theme = .Red
            bucketBarButton.image = UIImage(named: "RedPaintBucket")?.imageWithRenderingMode(.AlwaysOriginal)
            AppearanceController.sharedController.toggleTheme()
        } else {
            AppearanceController.sharedController.theme = .Blue
            bucketBarButton.image = UIImage(named: "BluePaintBucket")?.imageWithRenderingMode(.AlwaysOriginal)
            AppearanceController.sharedController.toggleTheme()
        }
        AppearanceController.sharedController.loadTheme()
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
        self.view.backgroundColor = .themeDarkestGray()
        if AppearanceController.sharedController.theme == .Blue {
            self.headerView.backgroundColor = .themeBlue()
        } else {
            self.headerView.backgroundColor = .themeRedLight()
        }
        self.tableView.reloadData()
    }
    
    @IBAction func createGameButtonTapped() {
        presentCreateGameAlert()
    }
    
    func createGameCellButtonTapped() {
        presentCreateGameAlert()
    }
    
    func presentCreateGameAlert() {
        
        if let view = UIView.loadFromNibNamed("CreateGameView") as? CreateGameView
        {
            let blurEffect = UIBlurEffect(style: .Light)
            blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = (self.navigationController?.view.bounds)!
            
            view.alpha = 0.0
            let frame = CGRectMake(30, self.view.center.x - 150, UIScreen.mainScreen().bounds.width - 60, 350)
            view.frame = frame
            view.delegate = self
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
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if finished == false {
            if GameController.sharedController.unfinishedGames.count > 0 {
                return GameController.sharedController.unfinishedGames.count
            } else {
                return 1
            }
        } else {
            if GameController.sharedController.finishedGames.count > 0 {
                return GameController.sharedController.finishedGames.count
            } else {
                return 1
            }
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if finished == false {
            if GameController.sharedController.unfinishedGames.count > 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("unfinishedGamesCell", forIndexPath: indexPath) as? GameTableViewCell
                
                let game = GameController.sharedController.unfinishedGames[indexPath.section]
                
                var gameScoreTypeString = ""
                if game.scoreType == 0 {
                    gameScoreTypeString = "High Score"
                } else {
                    gameScoreTypeString = "Low Score"
                }
                
                if AppearanceController.sharedController.theme == .Blue {
                    cell?.backgroundColor = .themeBlue()
                    
                    cell?.updateWith(game.name, date: NSDate.englishStringFromDate(game.date), playerCount: game.players?.count ?? 0, finished: false, scoreType: gameScoreTypeString, textColor: .themeDarkestGray())
                    //cell?.contentView.layer.cornerRadius = 27.4
                } else {
                    cell?.backgroundColor = .themeRedLight()
                    cell?.updateWith(game.name, date: NSDate.englishStringFromDate(game.date), playerCount: game.players?.count ?? 0, finished: false, scoreType: gameScoreTypeString, textColor: .whiteColor())
                    //cell?.contentView.layer.cornerRadius = 27.4
                }
                
                return cell ?? UITableViewCell()
                
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("noGamesCell", forIndexPath: indexPath) as? NoDataTableViewCell
                cell?.delegate = self
                cell?.noDataLabel.text = "No unfinished games"
                cell?.noDataLabel.textColor = .whiteColor()
                if AppearanceController.sharedController.theme == .Blue {
                    cell?.createGameButton.hidden = false
                    cell?.createGameButton.backgroundColor = .themeBlue()
                } else {
                    cell?.createGameButton.hidden = false
                    cell?.createGameButton.backgroundColor = .themeRedLight()
                }
                
                return cell ?? UITableViewCell()
            }
        } else {
            if GameController.sharedController.finishedGames.count > 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("unfinishedGamesCell", forIndexPath: indexPath) as? GameTableViewCell
                
                let game = GameController.sharedController.finishedGames[indexPath.section]
                if let players = game.players?.allObjects as? [Player] {
                    var gameScoreTypeString = ""
                    
                    var sortedPlayers: [Player] = []
                    if game.scoreType == 0 {
                        gameScoreTypeString = "High Score"
                        sortedPlayers = players.sort({ $0.score!.integerValue > $1.score!.integerValue })
                    } else {
                        gameScoreTypeString = "Low Score"
                        sortedPlayers = players.sort({ $0.score!.integerValue < $1.score!.integerValue })
                    }
                    
                    if let winner = sortedPlayers.first, _ = winner.score {
                        if AppearanceController.sharedController.theme == .Blue {
                            cell?.backgroundColor = .themeBlue()
                            
                            cell?.updateWith(game.name, date: NSDate.englishStringFromDate(game.date), playerCount: players.count, finished: true, scoreType: gameScoreTypeString, textColor: .themeDarkestGray())
                            //cell?.contentView.layer.cornerRadius = 27.4
                        } else {
                            cell?.backgroundColor = .themeRedLight()
                            cell?.updateWith(game.name, date: NSDate.englishStringFromDate(game.date), playerCount: players.count, finished: true, scoreType: gameScoreTypeString, textColor: .whiteColor())
                            //cell?.contentView.layer.cornerRadius = 27.4
                        }
                    }

                    return cell ?? UITableViewCell()
                
                } else {
                    let cell = tableView.dequeueReusableCellWithIdentifier("noGamesCell", forIndexPath: indexPath) as? NoDataTableViewCell
                    cell?.delegate = self
                    cell?.noDataLabel.text = "No finished games"
                    cell?.noDataLabel.textColor = .whiteColor()
                    if AppearanceController.sharedController.theme == .Blue {
                        cell?.createGameButton.hidden = true
                    } else {
                        cell?.createGameButton.hidden = true
                    }
                    
                    return cell ?? UITableViewCell()
                }
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("noGamesCell", forIndexPath: indexPath) as? NoDataTableViewCell
                cell?.delegate = self
                cell?.noDataLabel.text = "No finished games"
                cell?.noDataLabel.textColor = .whiteColor()
                if AppearanceController.sharedController.theme == .Blue {
                    cell?.createGameButton.hidden = true
                } else {
                    cell?.createGameButton.hidden = true
                }
                
                return cell ?? UITableViewCell()
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if finished == false {
            if GameController.sharedController.unfinishedGames.count > 0 {
                self.game = GameController.sharedController.unfinishedGames[indexPath.section]
                self.performSegueWithIdentifier("toPlayerView", sender: nil)
            }
        } else {
            if GameController.sharedController.finishedGames.count > 0 {
                self.game = GameController.sharedController.finishedGames[indexPath.section]
                self.performSegueWithIdentifier("toScoreView", sender: nil)
            }
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if finished == false {
            if GameController.sharedController.unfinishedGames.count > 0 {
                return 55
            } else {
                return 150
            }
        } else {
            if GameController.sharedController.finishedGames.count > 0 {
                return 55
            } else {
                return 150
            }
        }
        
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if finished == false {
                if indexPath.row == 0 {
                    let game = GameController.sharedController.unfinishedGames[indexPath.section]
                    GameController.sharedController.deleteGame(game)
                    tableView.reloadData()
                } else {
                    let game = GameController.sharedController.unfinishedGames[indexPath.section]
                    GameController.sharedController.deleteGame(game)
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                }
            } else {
                if indexPath.row == 0 {
                    let game = GameController.sharedController.finishedGames[indexPath.section]
                    GameController.sharedController.deleteGame(game)
                    tableView.reloadData()
                } else {
                    let game = GameController.sharedController.finishedGames[indexPath.section]
                    GameController.sharedController.deleteGame(game)
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 10))
        view.backgroundColor = .clearColor()
        return view
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 0))
        view.backgroundColor = .clearColor()
        return view
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toPlayerView" {
            if let playerVC = segue.destinationViewController as? PlayersTableViewController {
                playerVC.game = self.game
            }
        } else if segue.identifier == "toScoreView" {
            if let scoreVC = segue.destinationViewController as? ScoreViewController {
                scoreVC.game = self.game
            }
        }
    }
    
}
