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
                let address: String?
                let capacity: String?
                let image: String?
                let images: [String]?
                let name: String?
                let rooms: Int?
                let space: String?
            }
            var displayoffice : OfficeDetail
        }
        
    }
    
}
// swiftlint:enable nesting
