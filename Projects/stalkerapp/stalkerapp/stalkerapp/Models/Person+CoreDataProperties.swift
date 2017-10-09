//
//  Person+CoreDataProperties.swift
//  stalkerapp
//
//  Created by Carlos Lozano on 10/8/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var address: String?
    @NSManaged public var age: String?
    @NSManaged public var ageRange: String?
    @NSManaged public var date: Date?
    @NSManaged public var fullName: String?
    @NSManaged public var gender: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var photoUrl: String?
    @NSManaged public var email: String?
    @NSManaged public var medias: NSSet?

}

