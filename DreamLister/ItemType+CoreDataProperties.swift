//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Ricardo Lousada on 08/10/17.
//  Copyright © 2017 IT-4-ALL. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var itemType: String?
    @NSManaged public var toItem: Item?

}
