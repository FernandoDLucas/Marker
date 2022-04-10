//
//  Comic+CoreDataProperties.swift
//  NetworkingKit
//
//  Created by Fernando de Lucas da Silva Gomes on 10/04/22.
//  Copyright © 2022 Marker. All rights reserved.
//
//

import Foundation
import CoreData


extension Comic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comic> {
        return NSFetchRequest<Comic>(entityName: "Comic")
    }

    @NSManaged public var currentProgress: Int32
    @NSManaged public var author: String?
    @NSManaged public var total: Int32
    @NSManaged public var cover: Data?
    @NSManaged public var title: String
    @NSManaged public var status: Int16
    @NSManaged public var organizedBy: Int16

}

extension Comic : Identifiable {

}
