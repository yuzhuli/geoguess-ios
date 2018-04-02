//
//  City.swift
//  StreetView
//
//  Created by LiYuzhu on 3/18/18.
//  Copyright © 2018 LiYuzhu. All rights reserved.
//

import Foundation
import ObjectMapper

class City: Mappable {
  var country: String!
  var cityName: String!
  var latitude: Double!
  var longitude: Double!
  
  required init?(map: Map) {
  }
  
  func mapping(map: Map) {
    country          <- map["Country"]
    cityName         <- map["City"]
    latitude         <- map["Latitude"]
    longitude        <- map["Longitude"]
  }
}

extension City: Equatable {
  static func ==(lhs: City, rhs: City) -> Bool {
    return lhs.cityName == rhs.cityName && lhs.country == rhs.country && lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
  }
}
