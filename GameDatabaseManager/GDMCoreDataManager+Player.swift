//
//  GDMCoreDataManager+Player.swift
//  GameDatabaseManager
//
//  Created by Oscar Hernandez on 07/04/20.
//  Copyright © 2020 Oscar Hernandez. All rights reserved.
//

import Foundation
import CoreData

typealias PlayerResult = (error: Error?, player: Player?)

extension GDMCoreDataManager {
    func createPlayer(username: String) -> PlayerResult {
        let context = persistentContainer.viewContext
        let player = Player(context: context)
        player.id = UUID()
        player.username = username
        
        do {
            try context.save()
            return (nil, player)
        } catch {
            print("Error creating player: \(error.localizedDescription)")
            return (error, nil)
        }
    }
}
