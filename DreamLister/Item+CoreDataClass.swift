//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Ricardo Lousada on 08/10/17.
//  Copyright © 2017 IT-4-ALL. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {

    public override func awakeFromInsert(){
    
        super.awakeFromInsert()
        self.created = NSDate()
        
    }
    
    
}
