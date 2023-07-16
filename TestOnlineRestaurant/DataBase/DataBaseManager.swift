//
//  DataBaseManager.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 09.07.2023.
//

import Foundation
import CoreData

final class DataBaseManager: NSObject {
    
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "OrderModel")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresilved error \(error), \(error.userInfo)")
            }
            print("Core Data stack has been initialized with description: \(storeDescription)")
        }
        return container
    }()
}
