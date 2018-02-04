//
//  GeoUtils.swift
//  StreetView
//
//  Created by LiYuzhu on 2/3/18.
//  Copyright © 2018 LiYuzhu. All rights reserved.
//

import Foundation

struct GeoLocation {
  let latitude: Double
  let longitude: Double
}

class GeoUtils {
  static func randomSFLocation() -> GeoLocation {
    let randomLatitude = Double(37.73) + Double(arc4random_uniform(5)) / 100
    let randomLongitude = Double(-122.39) - Double(arc4random_uniform(9)) / 100
    let randomSFPlace = GeoLocation(latitude: randomLatitude, longitude: randomLongitude)
    print(randomLatitude)
    print(randomLongitude)
    return randomSFPlace
  }
}
