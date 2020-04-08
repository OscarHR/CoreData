//
//  GameDatabaseManagerTests.swift
//  GameDatabaseManagerTests
//
//  Created by Oscar Hernandez on 07/04/20.
//  Copyright © 2020 Oscar Hernandez. All rights reserved.
//

import XCTest
@testable import GameDatabaseManager

class GameDatabaseManagerTests : XCTestCase {
    var cdManager = GDMCoreDataManager.init(momd: "GameDatabaseDataModel")
    
    override func setUp() {

    }
    
    override func tearDown() {
        cdManager.deleteAllPlayers()
        cdManager.deleteAllGames()
    }
}

// MARK: - Player tests
extension GameDatabaseManagerTests {
    func testCreatePlayer() {
        let result = cdManager.createPlayer(username: "Player1")
        
        XCTAssertNotNil(result)
    }
    
    func testFetchPlayerById() {
        let player = cdManager.createPlayer(username: "Player1")!
        
        let result = cdManager.fetchPlayer(by: player.id!)
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.id, player.id)
    }
    
    func testFetchPlayerByUsername() {
        let player = cdManager.createPlayer(username: "Player1")!
        
        let result = cdManager.fetchPlayers(by: "Player1")
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result.first!.username, player.username)
    }
    
    func testFetchAllPlayers() {
        var players = cdManager.fetchAllPlayers()
        
        XCTAssertEqual(players.count, 0)
        
        createPlayer(withName: "Player1")
        players = cdManager.fetchAllPlayers()
        
        XCTAssertEqual(players.count, 1)
        
        createPlayer(withName: "Player2")
        players = cdManager.fetchAllPlayers()
        
        XCTAssertEqual(players.count, 2)
    }
    
    func testDeleteAllPlayers() {
        createPlayer(withName: "Player1")
        createPlayer(withName: "Player2")
        createPlayer(withName: "Player3")

        var players = cdManager.fetchAllPlayers()
               
        XCTAssertEqual(players.count, 3)
        
        cdManager.deleteAllPlayers()
        players = cdManager.fetchAllPlayers()
        
        XCTAssertEqual(players.count, 0)
    }
}

// MARK: - Games tests
extension GameDatabaseManagerTests {
    func testCreateGame() {
        let result = cdManager.createGame(named: "Zelda")
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.name ?? "", "Zelda")
    }
    
    func testFetchGameById() {
        let game = cdManager.createGame(named: "Darkest Dungeon")!
        
        let result = cdManager.fetchGameBy(id: game.id!)!
        
        XCTAssertEqual(game.id!, result.id!)
    }
    
    func testFetchGameByName() {
        let game = cdManager.createGame(named: "Halo")!
        let result = cdManager.fetchGamesBy(name: "Halo").first!
        
        XCTAssertEqual(game.name!, result.name!)
    }
    
    func testDeleteAllGames() {
        createGame(withName: "Zelda")
        createGame(withName: "Darkest Dungeon")
        createGame(withName: "Halo")

        var games = cdManager.fetchAllGames()
               
        XCTAssertEqual(games.count, 3)
        
        cdManager.deleteAllGames()
        games = cdManager.fetchAllGames()
        
        XCTAssertEqual(games.count, 0)
    }
}

// MARK: - Utilities
extension GameDatabaseManagerTests {
    func createPlayer(withName name: String) {
        _ = cdManager.createPlayer(username: name)!
    }
    
    func createGame(withName name: String) {
        _ = cdManager.createGame(named: name)
    }
}
