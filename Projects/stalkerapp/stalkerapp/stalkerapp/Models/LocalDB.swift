//
//  LocalDB.swift
//  stalkerapp
//
//  Created by Carlos Lozano on 10/8/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import Foundation

class LocalDB{
    
    let stack = CoreDataStack(modelName: "Model")
    
    private init (){
    }
    
    static let shared = LocalDB()
    
}
