//
//  GamesTableViewController.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/10/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class GamesTableViewController: UITableViewController, UpdateNavigationBarAppearanceDelegate {

    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.contentInset = UIEdgeInsets(top: -36, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        AppearanceController.sharedController.loadTheme()
        AppearanceController.sharedController.navigationBarAppearanceDelegate = self
    }
    
    @IBAction func changeThemeButtonTapped() {
        if AppearanceController.sharedController.theme == .Blue {
            AppearanceController.sharedController.theme = .Red
            AppearanceController.sharedController.toggleTheme()
        } else {
            AppearanceController.sharedController.theme = .Blue
            AppearanceController.sharedController.toggleTheme()
        }
        AppearanceController.sharedController.loadTheme()
    }
    
    func updateNagivationBarAppearanceToThemeColor(color: UIColor, tintColor: UIColor, barStyle: UIBarStyle) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : tintColor]
        self.navigationController?.navigationBar.barTintColor = color
        self.navigationController?.navigationBar.barStyle = barStyle
        self.navigationController?.navigationBar.tintColor = tintColor
    }
    
    @IBAction func createGameButtonTapped() {
        let alert = UIAlertController(title: "Create a Game", message: "Enter the name for your game", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler { (textfield) in
            textfield.placeholder = "name"
            textfield.keyboardType = .Default
            textfield.keyboardAppearance = .Light
            textfield.autocapitalizationType = .Words
        }
        
        let create = UIAlertAction(title: "Create", style: .Default) { (_) in
            if let text = alert.textFields?[0].text {
                GameController.sharedController.createGame(text)
                self.tableView.reloadData()
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alert.addAction(create)
        alert.addAction(cancel)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return GameController.sharedController.games.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("gamesCell", forIndexPath: indexPath)
        
        let game = GameController.sharedController.games[indexPath.row]
        cell.textLabel?.text = game.name
        cell.textLabel?.textAlignment = .Center
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.game = GameController.sharedController.games[indexPath.row]
        self.performSegueWithIdentifier("toPlayerView", sender: nil)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "toPlayerView" {
            if let playerVC = segue.destinationViewController as? PlayersTableViewController {
                playerVC.game = self.game
            }
        }
    }

}
