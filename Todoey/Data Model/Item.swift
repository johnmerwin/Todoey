//
//  Item.swift
//  Todoey
//
//  Created by John Merwin on 5/27/18.
//  Copyright © 2018 John Merwin. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    // Define a relationship between an item and its
    // parent category. Every item will have a parent
    // category associated with it
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")

    
}
