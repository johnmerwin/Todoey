//
//  AppDelegate.swift
//  Todoey
//
//  Created by John Merwin on 5/20/18.
//  Copyright © 2018 John Merwin. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Get the location of the real file on the computer
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // Create an instance of a realm object
        do {
            _ = try Realm()
        } catch {
            print("Error initializing realm \(error)")
        }
        return true
    }
}

