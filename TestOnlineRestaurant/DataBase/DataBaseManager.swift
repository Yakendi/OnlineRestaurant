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
    func fetchCartArray() -> [MenuModel] {
        var cartArray: [MenuModel] = []

        do {
            let tackedData = try viewContext.fetch(request)
            cartArray = tackedData.map {
                return MenuModel(
                    id: Int($0.id),
                    name: $0.name ?? "",
                    price: Int($0.price),
                    weight: Int($0.weight),
                    description: "",
                    image: $0.imageURL ?? ""
                )
            }
        } catch {
            print(error.localizedDescription)
        }

        return cartArray
    }
    
    func saveToCartModel(_ model: MenuModel) {
        let saveEntity = OrderModelEntity(context: viewContext)
        saveEntity.id = Int64(model.id)
        saveEntity.name = model.name
        saveEntity.price = Int64(model.price)
        saveEntity.weight = Int64(model.weight)
        saveEntity.imageURL = model.image
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func removeFromCartModel(_ model: MenuModel) {
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
    
    func updateFavoriteStatus(_ model: MenuModel) {
        let predicate = NSPredicate(format: "id like %@", model.id)
        request.predicate = predicate
        
        do {
            let context = persistentContainer.viewContext
            let fetchedResults = try context.fetch(request)
            if let entity = fetchedResults.first {
                entity.isFavorite = model.isFavorite
                try context.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
