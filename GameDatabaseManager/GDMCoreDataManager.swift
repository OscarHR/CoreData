//
//  GDMCoreDataManager.swift
//  GameDatabaseManager
//
//  Created by Oscar Hernandez on 07/04/20.
//  Copyright © 2020 Oscar Hernandez. All rights reserved.
//

import Foundation
import CoreData

class GDMCoreDataManager {
    let momd : String
    init(momd: String) {
        self.momd = momd
    }
    
    private static var container : NSPersistentContainer?

    lazy var persistentContainer : NSPersistentContainer = {
        guard let container = GDMCoreDataManager.container  else {
            guard let modelURL = Bundle(for: type(of: self)).url(forResource: momd, withExtension:"momd") else {
                    fatalError("Error loading model from bundle")
            }

            guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
                fatalError("Error initializing mom from: \(modelURL)")
            }
            
            print("Database loading")
            let container = NSPersistentContainer(name: momd, managedObjectModel: mom)
            
            container.loadPersistentStores { (desc, error) in
                if let error = error {
                    fatalError("Error loading database: \(error.localizedDescription)")
                }
            }
            print("Database loaded")
            
            GDMCoreDataManager.container = container
            return container
        }
        
        return container
    }()
}
