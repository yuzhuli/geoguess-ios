//
//  Challenge.swift
//  StreetView
//
//  Created by Hongze Zhao on 2/5/18.
//  Copyright © 2018 LiYuzhu. All rights reserved.
//

import Foundation
import GoogleMaps

struct Round {
  let initialGeoLocation: CLLocationCoordinate2D
}

struct Challenge {
  let name: String
  let description: String
  let rounds: [Round]
}

class ChallengeManager {
  lazy var singleTestingChallenge: Challenge = {
    return Challenge(
      name: "single testing challenge",
      description: "test description",
      rounds: [Round(initialGeoLocation: GeoUtils.randomSFLocation())])
  }()
  
  lazy var doubleTestingChallenge: Challenge = {
    return Challenge(
      name: "double testing challenge",
      description: "test description",
      rounds: [Round(initialGeoLocation: GeoUtils.randomSFLocation()), Round(initialGeoLocation: GeoUtils.randomSFLocation())])
  }()

  static var shared: ChallengeManager = {
    return ChallengeManager()
  }()
}
