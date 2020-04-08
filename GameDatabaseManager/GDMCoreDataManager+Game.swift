//
//  GDMCoreDataManager+Game.swift
//  GameDatabaseManager
//
//  Created by Oscar Hernandez on 08/04/20.
//  Copyright © 2020 Oscar Hernandez. All rights reserved.
//

import Foundation
import CoreData

extension GDMCoreDataManager {
    // MARK: - Insert
    func createGame(named name: String) -> Game? {
        let context = persistentContainer.viewContext
        let game = Game(context: context)
        game.id = UUID()
        game.name = name
        
        do {
            try context.save()
            return game
        } catch {
            print("Error creating player: \(error.localizedDescription)")
            return nil
        }
    }
    
    // MARK: - Select
    func fetchGameBy(id: UUID) -> Game? {
        let predicate = NSPredicate(format: "id == %@", id.uuidString)
        let result = performGameFetch(withPredicate: predicate)
        
        return result.first
    }
    
    func fetchGamesBy(name: String) -> [Game] {
        let predicate = NSPredicate(format: "name == %@", name)
        let result = performGameFetch(withPredicate: predicate)
        
        return result
    }
    
    func fetchAllGames() -> [Game] {
        return performGameFetch(withPredicate: nil)
    }
    
    func performGameFetch(withPredicate predicate: NSPredicate?) -> [Game] {
        let fetchRequest : NSFetchRequest<Game> = Game.fetchRequest()
        fetchRequest.predicate = predicate
        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest)
            return result
        } catch {
            print("Error fetching player: \(error.localizedDescription)")
            return [Game]()
        }
    }
    
    // MARK: - Delete
    func deleteAllGames() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.resultType = .resultTypeCount

        do {
            let result = try persistentContainer.viewContext.execute(deleteRequest) as! NSBatchDeleteResult
            print("Deleted no. of records: \(String(describing: result.result))")
        } catch {
            print("Error deleting all games")
        }
    }
}
