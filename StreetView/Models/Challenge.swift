//
//  Challenge.swift
//  StreetView
//
//  Created by Hongze Zhao on 2/5/18.
//  Copyright © 2018 LiYuzhu. All rights reserved.
//

import Foundation

struct Round {
  let initialGeoLocation: GeoLocation
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

  static var shared: ChallengeManager = {
    return ChallengeManager()
  }()
}
