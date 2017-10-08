//
//  Note+CoreDataProperties.swift
//  coolNotes
//
//  Created by Carlos Lozano on 9/21/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var creationDate: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var notebook: Notebook?

}
