//
//  OfficeAnnotation.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 21.08.2022.
//

import Foundation
import MapKit

class OfficeAnnotation : NSObject,MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D ,title: String)
    {
        self.coordinate = coordinate
        self.title = title
    }
}
