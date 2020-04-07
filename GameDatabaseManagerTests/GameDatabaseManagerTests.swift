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
    

    func testCreatePlayer() {
        let result = cdManager.createPlayer(username: "Redscool")
        
        XCTAssertNotNil(result.player)
    }
}
