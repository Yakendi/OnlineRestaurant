//
//  OrderModelEntity+CoreDataProperties.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 09.07.2023.
//
//

import Foundation
import CoreData


extension OrderModelEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderModelEntity> {
        return NSFetchRequest<OrderModelEntity>(entityName: "OrderModelEntity")
    }

    @NSManaged public var imageURL: String?
    @NSManaged public var weight: Int64
    @NSManaged public var price: Int64
    @NSManaged public var name: String?
    @NSManaged public var id: Int64
    @NSManaged public var orderCount: Int64
    @NSManaged public var isFavorite: Bool
}

extension OrderModelEntity : Identifiable {

}
