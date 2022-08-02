//
//  ListOfficesModels.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 1.08.2022.
//

import Foundation

// swiftlint:disable nesting
enum ListOffices {
    
    enum FetchOffices {
        
        struct Request {
           
        }
        
        struct Response {
            var Offices: [Office]
        }
        
        struct ViewModel {
            struct DisplayedOffice {
                let address, capacity: String?
                let id: Int?
                let image: String?
                let location: Location?
                let name: String?
                let rooms: Int?
                let space: String?
            }
            var displayedOffices: [DisplayedOffice]
        }
        
    }
    
}

// swiftlint:enable nesting
