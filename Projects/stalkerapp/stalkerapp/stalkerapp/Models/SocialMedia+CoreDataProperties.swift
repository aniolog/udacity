//
//  SocialMedia+CoreDataProperties.swift
//  stalkerapp
//
//  Created by Carlos Lozano on 10/15/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//
//

import Foundation
import CoreData


extension SocialMedia {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SocialMedia> {
        return NSFetchRequest<SocialMedia>(entityName: "SocialMedia")
    }

    @NSManaged public var date: Date?
    @NSManaged public var typeName: String?
    @NSManaged public var url: String?
    @NSManaged public var username: String?
    @NSManaged public var person: Person?

}
