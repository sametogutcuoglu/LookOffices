//
//  ModelOffices.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 1.08.2022.
//

import Foundation

struct Office: Codable {
    let address, capacity: String?
    let id: Int?
    let image: String?
    let location: Location?
    let name: String?
    let rooms: Int?
    let space: String?
}

// MARK: - Location
struct Location: Codable {
    let latitude, longitude: Double
}
