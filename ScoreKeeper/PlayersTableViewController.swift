//
//  PlayersTableViewController.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/10/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class PlayersTableViewController: UITableViewController, UpdateNavigationBarAppearanceDelegate {
    
    @IBOutlet weak var scoreViewButton: UIButton!
    @IBOutlet weak var gameTitleLabel: UILabel!
    
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        if let game = self.game {
            gameTitleLabel.text = game.name
        }
        AppearanceController.sharedController.navigationBarAppearanceDelegate = self
        
        AppearanceController.sharedController.loadTheme()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        toggleScoreViewButtonEnabled()
        self.tableView.reloadData()
        self.view.setNeedsDisplay()
    }
    
    func toggleScoreViewButtonEnabled() {
        if let game = self.game {
            if game.players!.count == 0 {
                self.scoreViewButton.enabled = false
                self.scoreViewButton.setTitleColor(.lightGrayColor(), forState: .Normal)
            } else {
                self.scoreViewButton.enabled = true
                if AppearanceController.sharedController.theme == .Blue {
                    self.scoreViewButton.setTitleColor(UIColor(red: 0.184, green: 0.184, blue: 0.184, alpha: 1.00), forState: .Normal)
                } else {
                    self.scoreViewButton.setTitleColor(.whiteColor(), forState: .Normal)
                }
                
            }
        }
    }
    
    func updateNagivationBarAppearanceToThemeColor(color: UIColor, tintColor: UIColor, barStyle: UIBarStyle) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : tintColor]
        self.scoreViewButton.backgroundColor = color
        self.scoreViewButton.setTitleColor(tintColor, forState: .Normal)
        self.scoreViewButton.layer.cornerRadius = self.scoreViewButton.frame.height / 2
        self.navigationController?.navigationBar.barTintColor = color
        self.navigationController?.navigationBar.barStyle = barStyle
        self.navigationController?.navigationBar.tintColor = tintColor
    }
    
    @IBAction func createGameButtonTapped() {
        let alert = UIAlertController(title: "Create New Player", message: "Enter the name for the new player", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler { (textfield) in
            textfield.placeholder = "name"
            textfield.keyboardType = .Default
            textfield.keyboardAppearance = .Light
            textfield.autocapitalizationType = .Words
        }
        
        let create = UIAlertAction(title: "Create", style: .Default) { (_) in
            if let game = self.game, text = alert.textFields?[0].text {
                GameController.sharedController.addPlayerToGame(text, game: game)
                self.toggleScoreViewButtonEnabled()
                self.tableView.reloadData()
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alert.addAction(create)
        alert.addAction(cancel)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func scoreViewButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("toScoringView", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let players = game?.players?.allObjects as? [Player] {
            return players.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("playerCell", forIndexPath: indexPath) as? PlayerTableViewCell {
            if let players = game?.players?.allObjects as? [Player] {
                let sortedPlayers = players.sort({ $0.name < $1.name })
                let player = sortedPlayers[indexPath.row]
                cell.updateWith(player)
                
                return cell
            } else {
                return UITableViewCell()
            }
        } else {
            return UITableViewCell()
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            if let game = self.game, players = game.players?.allObjects as? [Player] {
                let sortedPlayers = players.sort({$0.name < $1.name})
                let player = sortedPlayers[indexPath.row]
                tableView.beginUpdates()
                GameController.sharedController.deletePlayerFromGame(player)
                toggleScoreViewButtonEnabled()
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                tableView.endUpdates()
            }
        }
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toScoringView" {
            if let scoreVC = segue.destinationViewController as? ScoreKeeperViewController {
                scoreVC.game = self.game
            }
        }
    }
}
