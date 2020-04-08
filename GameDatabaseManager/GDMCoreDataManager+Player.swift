//
//  GDMCoreDataManager+Player.swift
//  GameDatabaseManager
//
//  Created by Oscar Hernandez on 07/04/20.
//  Copyright © 2020 Oscar Hernandez. All rights reserved.
//

import Foundation
import CoreData

extension GDMCoreDataManager {
    // MARK: - Insert
    func createPlayer(username: String) -> Player? {
        let context = persistentContainer.viewContext
        let player = Player(context: context)
        player.id = UUID()
        player.username = username
        
        do {
            try context.save()
            return player
        } catch {
            print("Error creating player: \(error.localizedDescription)")
            return nil
        }
    }
    
    // MARK: - Select
    func fetchPlayer(by id: UUID) -> Player? {
        let predicate = NSPredicate(format: "id == %@", id.uuidString)
        let result = performPlayerFetch(withPredicate: predicate)
        
        return result.first
    }
    
    func fetchAllPlayers() -> [Player] {
        return performPlayerFetch(withPredicate: nil)
    }
    
    func performPlayerFetch(withPredicate predicate: NSPredicate?) -> [Player] {
        let fetchRequest : NSFetchRequest<Player> = Player.fetchRequest()
        fetchRequest.predicate = predicate
        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest)
            return result
        } catch {
            print("Error fetching player: \(error.localizedDescription)")
            return [Player]()
        }
    }
    
    // MARK: - Delete
    func deleteAllPlayers() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.resultType = .resultTypeCount

        do {
            let result = try persistentContainer.viewContext.execute(deleteRequest) as! NSBatchDeleteResult
            print("Deleted no. of records: \(String(describing: result.result))")
        } catch {
            print("Error deleting all players")
        }
    }
}
