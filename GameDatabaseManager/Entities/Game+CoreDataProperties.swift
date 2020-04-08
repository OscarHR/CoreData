//
//  Game+CoreDataProperties.swift
//  GameDatabaseManager
//
//  Created by Oscar Hernandez on 08/04/20.
//  Copyright © 2020 Oscar Hernandez. All rights reserved.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?

}
