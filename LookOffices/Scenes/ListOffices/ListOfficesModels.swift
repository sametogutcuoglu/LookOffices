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
        
        struct Request {}

        struct Response {
            var offices: [Office]
        }

        struct ViewModel {
            struct Office {
                let capacity: String
                let id: Int
                let image: String
                let name: String
                let rooms: Int
                let space: String
            }

            var Offices: [Office]
        }
    }
}

// swiftlint:enable nesting
