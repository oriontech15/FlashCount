//
//  GameController.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/10/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import CoreData

class GameController {
    
    static let sharedController = GameController()
    
    var unfinishedGames: [Game] {
        
        let request = NSFetchRequest(entityName: "Game")
        let predicate = NSPredicate(format: "finished == 0")
        request.predicate = predicate
        
        let moc = Stack.sharedStack.managedObjectContext
        
        return (try? moc.executeFetchRequest(request)) as? [Game] ?? []
    }
    
    var finishedGames: [Game] {
        let request = NSFetchRequest(entityName: "Game")
        let predicate = NSPredicate(format: "finished == 1")
        request.predicate = predicate
        
        let moc = Stack.sharedStack.managedObjectContext
        
        return (try? moc.executeFetchRequest(request)) as? [Game] ?? []
    }
    
    init() {
        _ = unfinishedGames
        _ = finishedGames
    }
    
    func markGameAsFinished(game: Game) {
        game.finished = true
        save()
    }
    
    func markGameAsUnfinished(game: Game) {
        game.finished = false
        save()
    }
    
    func save() {
        let moc = Stack.sharedStack.managedObjectContext
        do {
            try moc.save()
        } catch {
            print("Error saving \(error)")
        }
    }
    
    func createGame(name: String, scoreType: NSNumber) {
        let _ = Game(name: name, scoreType: scoreType)
        save()
    }
    
    func deleteGame(game: Game) -> () {
        if let moc = game.managedObjectContext {
            moc.deleteObject(game)
            save()
        }
    }
    
    func deletePlayerFromGame(player: Player) {
        if let moc = player.managedObjectContext {
            moc.deleteObject(player)
            save()
        }
    }

    func addPlayerToGame(name: String, score: NSNumber? = NSNumber(integer: 0), game: Game) {
        let _ = Player(name: name, game: game, score: score, context: Stack.sharedStack.managedObjectContext)
        save()
    }
}