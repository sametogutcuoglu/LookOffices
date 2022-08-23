//
//  OfficeDetailModels.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 3.08.2022.
//

import Foundation

enum OfficeDetail {
    
    enum FetchOfficeDetail {
        
        struct Request {
            
        }
        
        struct Response {
            var offices : [Office]
        }
        
        struct ViewModel {
            
            struct OfficeDetail {
                let id : Int
                let address: String
                let capacity: String
                let officePosterImage: String
                let latitude: Double
                let longidute: Double
                let officeDetailimages: [String]
                let name: String
                let rooms: Int
                let space: String
            }
        }
    }
}
