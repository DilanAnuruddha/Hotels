//
//  HotelViewModel.swift
//  Hotels
//
//  Created by Dilan Anuruddha on 11/26/20.
//

import Foundation

struct HotelViewModel {
    let id: Int
    let title, hotelDescription, address, postcode: String
    let phoneNumber, latitude, longitude: String
    let image: Image
    
    init(hotel:Datum) {
        self.id = hotel.id
        self.title = hotel.title
        self.hotelDescription = hotel.datumDescription
        self.address = hotel.address
        self.postcode = hotel.postcode
        self.phoneNumber = hotel.phoneNumber
        self.latitude = hotel.latitude
        self.longitude = hotel.longitude
        self.image = hotel.image
    }
}
