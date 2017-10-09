//
//  SocialMedia+CoreDataClass.swift
//  stalkerapp
//
//  Created by Carlos Lozano on 10/8/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SocialMedia)
public class SocialMedia: NSManagedObject {

    convenience init(typeName: String,url:String,username:String, context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "SocialMedia", in: context) {
            self.init(entity: ent, insertInto: context)
            self.typeName = typeName
            self.url = url
            self.username = username
            self.date = Date()
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
}
