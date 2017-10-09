//
//  Person+CoreDataClass.swift
//  stalkerapp
//
//  Created by Carlos Lozano on 10/8/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {

    convenience init(email: String, context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "Person", in: context) {
            self.init(entity: ent, insertInto: context)
            self.email = email
            self.date = Date()
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
    
    
    
}
