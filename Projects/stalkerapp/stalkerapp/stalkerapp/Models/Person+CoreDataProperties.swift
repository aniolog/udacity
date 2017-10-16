//
//  Person+CoreDataProperties.swift
//  stalkerapp
//
//  Created by Carlos Lozano on 10/15/17.
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
    @NSManaged public var email: String?
    @NSManaged public var fullName: String?
    @NSManaged public var gender: String?
    @NSManaged public var photo: Data?
    @NSManaged public var photoUrl: String?
    @NSManaged public var medias: NSSet?

}

// MARK: Generated accessors for medias
extension Person {

    @objc(addMediasObject:)
    @NSManaged public func addToMedias(_ value: SocialMedia)

    @objc(removeMediasObject:)
    @NSManaged public func removeFromMedias(_ value: SocialMedia)

    @objc(addMedias:)
    @NSManaged public func addToMedias(_ values: NSSet)

    @objc(removeMedias:)
    @NSManaged public func removeFromMedias(_ values: NSSet)

}
