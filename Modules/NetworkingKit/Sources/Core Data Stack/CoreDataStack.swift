//
//  CoreDataStack.swift
//  NetworkingKit
//
//  Created by Fernando de Lucas da Silva Gomes on 10/04/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import CoreData

final class CoreDataStack {
    private let frameworkBundleID = "com.Marker.NetworkingKit"
    private let modelName = "Marker"
    
    init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let frameworkBundle = Bundle(identifier: self.frameworkBundleID)
        let modelURL = frameworkBundle!.url(forResource: self.modelName, withExtension: "momd")!
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)
        
        let container = NSPersistentContainer(name: self.modelName, managedObjectModel: managedObjectModel!)
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
} 
