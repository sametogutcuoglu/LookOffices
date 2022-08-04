//
//  OfficeDetailModels.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 3.08.2022.
//

import Foundation

// swiftlint:disable nesting
enum OfficeDetail {
    
    enum FetchOfficeDetail {
        
        struct Request {
            
        }
        
        struct Response {
            var office : Office?
        }
        
        struct ViewModel {
            struct OfficeDetail {
                let address, capacity: String?
                let id: Int?
                let image: String?
                let location: Location?
                let name: String?
                let rooms: Int?
                let space: String?
            }
            var officeDetail : Office
        }
        
    }
    
}
// swiftlint:enable nesting
