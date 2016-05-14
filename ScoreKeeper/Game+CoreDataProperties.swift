//
//  Game+CoreDataProperties.swift
//  ScoreKeeper
//
//  Created by Justin Smith on 5/11/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Game {

    @NSManaged var name: String
    @NSManaged var players: NSSet?

}
