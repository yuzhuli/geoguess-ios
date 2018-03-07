//
//  GeoUtils.swift
//  StreetView
//
//  Created by LiYuzhu on 2/3/18.
//  Copyright © 2018 LiYuzhu. All rights reserved.
//

import Foundation
import GoogleMaps

class GeoUtils {
  static func randomSFLocation() -> CLLocationCoordinate2D {
    let randomLatitude = Double(37.73) + Double(arc4random_uniform(5)) / 100
    let randomLongitude = Double(-122.39) - Double(arc4random_uniform(9)) / 100
    let randomSFPlace = CLLocationCoordinate2D(latitude: randomLatitude, longitude: randomLongitude)
    return randomSFPlace
  }
  
  static let initialMapPosition = CLLocationCoordinate2D(latitude: 0.00, longitude: 180.00)
}
