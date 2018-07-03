//
//  Person+CoreDataProperties.swift
//  CXCoreDataStack
//
//  Created by Augustine Odiadi on 03/07/2018.
//  Copyright © 2018 Augustine Odiadi. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var email: String?

}
