//
//  OfficeAnnotation.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 21.08.2022.
//

import Foundation
import MapKit

class OfficeAnnotation : NSObject,MKAnnotation {
    var subtitle: String?
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var id : Int
    
    init(coordinate: CLLocationCoordinate2D ,title: String,id : Int)
    {
        self.coordinate = coordinate
        self.title = title
        self.id = id
    }
}
