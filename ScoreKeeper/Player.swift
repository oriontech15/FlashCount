//
//  Player.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/10/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import CoreData


class Player: NSManagedObject {
    private let kName = "playerName"
    private let kScore = "playerScore"
    private let kPlayer = "player"
    
    convenience init?(name:String, game: Game, score: NSNumber? = 0, context:NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        guard let entity = NSEntityDescription.entityForName("Player", inManagedObjectContext: context) else {return nil}
        
        self.init(entity: entity, insertIntoManagedObjectContext:context)
        
        self.name = name
        self.score = score
        self.game = game
    }
}
