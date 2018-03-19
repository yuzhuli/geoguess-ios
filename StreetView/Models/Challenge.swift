//
//  Challenge.swift
//  StreetView
//
//  Created by Hongze Zhao on 2/5/18.
//  Copyright © 2018 LiYuzhu. All rights reserved.
//

import Foundation
import GoogleMaps
import SwiftyJSON
import ObjectMapper

struct Round {
  let initialGeoLocation: CLLocationCoordinate2D
  let country: String?
  let cityName: String?
}

struct Challenge {
  let name: String
  let description: String
  var rounds: [Round]
}

class ChallengeManager {
  lazy var singleTestingChallenge: Challenge = {
    return Challenge(
      name: "single testing challenge",
      description: "test description",
      rounds: [Round(initialGeoLocation: GeoUtils.randomSFLocation(), country: nil, cityName: nil)]
    )
  }()
  
  lazy var doubleTestingChallenge: Challenge = {
    return Challenge(
      name: "double testing challenge",
      description: "test description",
      rounds: [Round(initialGeoLocation: GeoUtils.randomSFLocation(), country: nil, cityName: nil), Round(initialGeoLocation: GeoUtils.randomSFLocation(), country: nil, cityName: nil)]
    )
  }()
  
  lazy var top5000Cities: [City]? = {
    let filePath = Bundle.main.path(forResource: "city5000", ofType: "json")
    if let data = try? Data(contentsOf: URL(fileURLWithPath: filePath!), options: .mappedIfSafe),
      let jsonCityArray = try? JSON(data: data) {
        return jsonCityArray.map { arg in
          return Mapper<City>().map(JSONString: arg.1.rawString() ?? "")
        }.flatMap { $0 }
    }
    return nil
  }()
  
  func generateCityChallenge() -> Challenge? {
    guard let top5000Cities = self.top5000Cities else {
      return nil
    }
    let rounds = generateCityChallengeRounds(top5000Cities: top5000Cities, amount: 5)
    return Challenge(
      name: "city challenge",
      description: "5 rounds of city challenge",
      rounds: rounds)
  }
  
  func generateCityChallengeRounds(top5000Cities: [City], amount: Int) -> [Round]{
    var randomCitiesRounds = [Round]()
    var allIndex = [Int]()
    for _ in 1...amount {
      var index = Int(arc4random_uniform(UInt32(top5000Cities.count)))
      while allIndex.contains(index) {
        index = Int(arc4random_uniform(UInt32(top5000Cities.count)))
      }
      allIndex.append(index)
      let city = top5000Cities[index]
      let coordinate = CLLocationCoordinate2D(latitude: city.latitude, longitude: city.longitude)
      let round = Round(initialGeoLocation: coordinate, country: city.country, cityName: city.cityName)
      randomCitiesRounds.append(round)
    }
    return randomCitiesRounds
  }

  static var shared: ChallengeManager = {
    return ChallengeManager()
  }()
}
