//
//  Hotel.swift
//  Hotels
//
//  Created by Dilan Anuruddha on 11/26/20.
//
import Foundation

// MARK: - Hotel
struct Hotel: Codable {
    let status: Int
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let title, datumDescription, address, postcode: String
    let phoneNumber, latitude, longitude: String
    let image: Image

    enum CodingKeys: String, CodingKey {
        case id, title
        case datumDescription = "description"
        case address, postcode, phoneNumber, latitude, longitude, image
    }
}

// MARK: - Image
struct Image: Codable {
    let small, medium, large: String
}


