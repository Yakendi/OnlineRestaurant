//
//  DataBaseManager.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 09.07.2023.
//

import Foundation
import CoreData

final class DataBaseManager: NSObject {
    
    // MARK: - Core Data stack
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "OrderModel")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresilved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    private let request: NSFetchRequest<OrderModelEntity> = OrderModelEntity.fetchRequest()
    
    // MARK: - Storage
    func fetchCartArray() -> [Dishes] {
        var cartArray: [Dishes] = []

        do {
            let tackedData = try viewContext.fetch(request)
            cartArray = tackedData.map {
                return Dishes(
                    id: Int($0.id),
                    name: $0.name ?? "",
                    price: Int($0.price),
                    weight: Int($0.weight),
                    description: "",
                    imageURL: $0.imageURL ?? ""
                )
            }
        } catch {
            print(error.localizedDescription)
        }

        return cartArray
    }
    
    func saveToCartModel(_ model: Dishes) {
        let saveEntity = OrderModelEntity(context: viewContext)
        saveEntity.id = Int64(model.id)
        saveEntity.name = model.name
        saveEntity.price = Int64(model.price)
        saveEntity.weight = Int64(model.weight)
        saveEntity.imageURL = model.imageURL
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func removeFromCartModel(_ model: Dishes) {
        let predicate = NSPredicate(format: "name like %@", model.name)
        request.predicate = predicate
        
        do {
            let objects = try viewContext.fetch(request)
            for object in objects {
                viewContext.delete(object)
            }
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
