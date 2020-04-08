//
//  Player+CoreDataProperties.swift
//  GameDatabaseManager
//
//  Created by Oscar Hernandez on 08/04/20.
//  Copyright © 2020 Oscar Hernandez. All rights reserved.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var username: String?

}
