//
//  FilterModels.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 12.08.2022.
//

import Foundation


enum Filter {
    
    enum Fetch {
        
        struct Request {
           
        }
        
        struct Response {
            var offices: [Office]
        }
        
        struct ViewModel {
            struct filterData {
                let capacity: String
                let rooms: Int
                let space: String
            }
            var offices : [filterData]
        }
        
    }
    
}
