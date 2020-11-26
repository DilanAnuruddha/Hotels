//
//  Services.swift
//  Hotels
//
//  Created by Dilan Anuruddha on 11/26/20.
//

import Foundation
import Alamofire

class Services {
    
    //MARK: get Hotel list
    public static func getHotelList(completionHandler:@escaping ([Datum]?, Error?) -> ()){
        AF.request(URL(string: API_URL.HotelList)!,
                   method: .get
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: Hotel.self) { (response) in
            guard let hotels = response.value else { return }
            completionHandler(hotels.data,nil)
          }
    }
}
