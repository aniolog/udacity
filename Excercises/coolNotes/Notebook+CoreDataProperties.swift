//
//  Notebook+CoreDataProperties.swift
//  coolNotes
//
//  Created by Carlos Lozano on 9/21/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import Foundation
import CoreData


extension Notebook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notebook> {
        return NSFetchRequest<Notebook>(entityName: "Notebook")
    }

    @NSManaged public var creationDate: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var notes: Note?

}
