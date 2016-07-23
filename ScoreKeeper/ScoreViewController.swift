//
//  ScoreViewController.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 6/3/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var winnerScoreLabel: UILabel!
    @IBOutlet weak var winnerNameLabel: UILabel!
    @IBOutlet weak var winnerTrophyImageView: UIImageView!
    @IBOutlet weak var winnerBackgroundImageView: WinnerImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var winnerView: WinnerView!
    @IBOutlet weak var winnerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var winnerViewHeightHeight: NSLayoutConstraint!
    
    @IBOutlet weak var leftSeparatorView: UIView!
    @IBOutlet weak var rightSeparatorView: UIView!
    @IBOutlet weak var playersTableView: UITableView!
    
    @IBOutlet weak var finishGameButton: CustomNavBarToggleThemeButton!
    @IBOutlet weak var rightSepWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftSepWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var playerListHeightConstraint: NSLayoutConstraint!
    
    var game: Game?
    var firstAnimation = true
    
    @IBOutlet weak var winnerTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let tap = UITapGestureRecognizer(target: self, action: #selector(bringViewDownFromTop))
        winnerView.addGestureRecognizer(tap)
        self.playersTableView.alpha = 0.0
        winnerView.hidden = true
        setupView()
        setupTableViewHeight()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        bringViewDownFromTop()
    }
    
    func setupTableViewHeight() {
        let bounds = UIScreen.mainScreen().bounds
        let height = bounds.size.height
        
        switch height {
        case 480.0:
            print("iPhone 3,4")
            playerListHeightConstraint.constant = 100
            winnerViewHeightHeight.constant = 390
        case 568.0:
            print("iPhone 5")
            playerListHeightConstraint.constant = 150
//            winnerViewHeightHeight.constant
        case 667.0:
            print("iPhone 6")
            playerListHeightConstraint.constant = 250

        case 736.0:
            print("iPhone 6+")
            playerListHeightConstraint.constant = 310
        default:
            print("not an iPhone")
            
        }
    }
    
    func setupView() {
        if AppearanceController.sharedController.theme == .Blue {
            winnerBackgroundImageView.image = UIImage(named: "Background-Blue")
            winnerTrophyImageView.image = UIImage(named: "Winner Trophy - Blue")
            winnerNameLabel.textColor = .themeDarkestGray()
            winnerScoreLabel.textColor = .themeDarkestGray()
            gameTitleLabel.textColor = .themeDarkestGray()
            winnerTextLabel.textColor = .themeDarkestGray()
            leftSeparatorView.backgroundColor = .themeBlue()
            rightSeparatorView.backgroundColor = .themeBlue()
            
        } else {
            winnerBackgroundImageView.image = UIImage(named: " Background-Red")
            winnerTrophyImageView.image = UIImage(named: "Winner Trophy - Red")
            
            winnerNameLabel.textColor = .whiteColor()
            winnerScoreLabel.textColor = .whiteColor()
            gameTitleLabel.textColor = .whiteColor()
            winnerTextLabel.textColor = .whiteColor()
            
            leftSeparatorView.backgroundColor = .themeRed()
            rightSeparatorView.backgroundColor = .themeRed()
        }
        
        if game?.finished == 0 {
            self.winnerTextLabel.text = "Winning"
            self.finishGameButton.setTitle("Finish Game", forState: .Normal)
        } else {
            self.winnerTextLabel.text = "Winner!"
            self.finishGameButton.setTitle("Restore", forState: .Normal)
        }
        
        if let game = self.game, players = game.players?.allObjects as? [Player] {
            if game.scoreType == 0 {
                let sortedPlayers = players.sort({ $0.score!.integerValue > $1.score!.integerValue })
                self.gameTitleLabel.text = game.name
                if let winningPlayer = sortedPlayers.first {
                    self.winnerNameLabel.text = winningPlayer.name
                    self.winnerScoreLabel.text = "\(winningPlayer.score!.integerValue)"
                }
            } else {
                let sortedPlayers = players.sort({ $0.score!.integerValue < $1.score!.integerValue })
                self.gameTitleLabel.text = game.name
                if let winningPlayer = sortedPlayers.first {
                    self.winnerNameLabel.text = winningPlayer.name
                    self.winnerScoreLabel.text = "\(winningPlayer.score!.integerValue)"
                }
            }
        }

    }
    
    func bringViewDownFromTop() {
        
        winnerView.hidden = false
        
        if winnerViewHeight.constant == -80 {
            UIView.animateWithDuration(0.2, animations: {
                self.winnerViewHeight.constant = -100
                self.view.layoutIfNeeded()
                }, completion: { (_) -> Void in
                    UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .CurveEaseInOut, animations: {
                    self.winnerViewHeight.constant = -80
                    self.view.layoutIfNeeded()
                    }, completion: nil)
            })
        } else {
            
            UIView.animateWithDuration(0.8, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.6, options: .CurveEaseInOut, animations: {
                self.winnerViewHeight.constant = -80
                
                self.view.layoutIfNeeded()
                }, completion: { (_) -> Void in
                    if self.firstAnimation {
                        UIView.animateWithDuration(1.3, animations: {
                            self.rightSepWidthConstraint.constant = 270
                            self.leftSepWidthConstraint.constant = 270
                            self.view.layoutIfNeeded()
                        })
                        
                        UIView.animateWithDuration(1.0, delay: 0.0, options: [], animations: {
                            self.playersTableView.alpha = 1.0
                            
                            }, completion: { (_) -> Void in
                                self.firstAnimation = false
                        })
                    }
            })
        }
    }
    
    @IBAction func finishGameButtonTapped(sender: AnyObject) {
        guard let game = self.game else { print("Game passed to Score View is nil"); return }
        
        if game.finished == false {
            let alert = UIAlertController(title: "Finish?", message: "Are you sure you want to finish this game?", preferredStyle: .Alert)
            let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            let finish = UIAlertAction(title: "Finish", style: .Default) { (action) in
                GameController.sharedController.markGameAsFinished(game)
                self.performSegueWithIdentifier("gameFinished", sender: nil)
            }
            
            alert.addAction(cancel)
            alert.addAction(finish)
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            GameController.sharedController.markGameAsUnfinished(game)
            self.performSegueWithIdentifier("gameFinished", sender: nil)
        }
        
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonTapped() {
        self.winnerView.hidden = true
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension ScoreViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let playersCount = game?.players?.count {
            return playersCount - 1
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("playerAndScoreCell", forIndexPath: indexPath) as? PlayerAndScoreTableViewCell
        
        if let players = self.game?.players?.allObjects as? [Player] {
            
            var sortedPlayers: [Player] = []
            if game?.scoreType == 0 {
                sortedPlayers = players.sort({ $0.score!.integerValue > $1.score!.integerValue })
            } else {
                sortedPlayers = players.sort({ $0.score!.integerValue < $1.score!.integerValue })
            }
            if indexPath.row + 1 == sortedPlayers.count {
                let player = sortedPlayers[indexPath.row]
                if firstAnimation {
                    cell?.contentView.alpha = 0
                    cell?.updateWithPlayer(player, index: indexPath.row)
                }
            } else {
                let player = sortedPlayers[indexPath.row + 1]
                cell?.updateWithPlayer(player, index: indexPath.row + 1)
            }
        }
        
        return cell ?? UITableViewCell()
    }
}
