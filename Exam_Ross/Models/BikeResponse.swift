//
//  BikeResponse.swift
//  Exam_Ross
//
//  Created by Ross on 2025-07-07.
//

import Foundation

struct BikeResponse: Codable {
    let networks: [Bike]
}

struct Bike: Identifiable, Codable {
    let id: String
    let name: String
    let location: Location
    let company: [String]?
    let ebikes: Bool?
}

struct Location: Codable {
    let city: String
    let country: String
    let latitude: Double
    let longitude: Double
}
