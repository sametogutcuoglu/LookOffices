//
//  OfficesMapViewModels.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 19.08.2022.
//

import Foundation

enum OfficesMapView {
    
    enum Fetch {
        
        struct Request {
            
        }
        
        struct Response {
            var OfficeMapInfo : [Office]
        }
        
        struct ViewModel {
            struct OfficeMapInfo {
                let id: Int
                let latitude: Double
                let longidute: Double
                let name: String
            }
            var officesMapInfo : [OfficeMapInfo]
        }
    }
}
