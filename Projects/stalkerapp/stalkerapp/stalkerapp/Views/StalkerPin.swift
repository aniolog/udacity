//
//  SAnnotation.swift
//  stalkerapp
//
//  Created by Carlos Lozano on 10/15/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import Foundation
import MapKit

class StalkerPin: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
    
    
}
