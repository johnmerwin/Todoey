//
//  Category.swift
//  Todoey
//
//  Created by John Merwin on 5/27/18.
//  Copyright © 2018 John Merwin. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    
    // Define a relationship between category and items
    // Every category is likely to have a list of items
    // associated with it.
    let items = List<Item>()
}
