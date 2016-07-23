//
//  Game.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/10/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import CoreData


class Game: NSManagedObject {
    
    convenience init?(name:String, scoreType: NSNumber = 0, date: NSDate = NSDate(), finished: NSNumber = 0, context:NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        guard let entity = NSEntityDescription.entityForName("Game", inManagedObjectContext: context) else {return nil}
        
        self.init(entity: entity, insertIntoManagedObjectContext:context)
        
        self.name = name
        self.scoreType = scoreType
        self.finished = finished
        self.date = date
    }
}
