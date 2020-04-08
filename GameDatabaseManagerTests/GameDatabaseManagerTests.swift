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
    var cdManager : GDMCoreDataManager!
    
    override func setUp() {
        cdManager = GDMCoreDataManager.init(momd: "GameDatabaseDataModel")
    }
    
    override func tearDown() {
        cdManager.deleteAllPlayers()
        cdManager = nil
    }

    func testCreatePlayer() {
        let result = cdManager.createPlayer(username: "Player1")
        
        XCTAssertNotNil(result)
    }
    
    func testFetchPlayer() {
        let player = cdManager.createPlayer(username: "Player1")!
        
        let result = cdManager.fetchPlayer(by: player.id!)
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.id, player.id)
    }
    
    func testFetchAllPlayers() {
        let players = cdManager.fetchAllPlayers()
        
        XCTAssertEqual(players.count, 0)
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

// MARK: - Utilities
extension GameDatabaseManagerTests {
    func createPlayer(withName name: String) {
        _ = cdManager.createPlayer(username: name)!
    }
}
