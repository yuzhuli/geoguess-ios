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
  let expectedAnswerIndex: Int?
  let allOptions: [City]?
}

struct Challenge {
  let name: String
  let description: String
  let challengeMode: String
  var rounds: [Round]
}

class ChallengeManager {
  lazy var singleTestingChallenge: Challenge = {
    return Challenge(
      name: "single testing challenge",
      description: "test description",
      challengeMode: "map",
      rounds: [Round(initialGeoLocation: GeoUtils.randomSFLocation(), expectedAnswerIndex: nil, allOptions: nil)]
    )
  }()
  
  lazy var doubleTestingChallenge: Challenge = {
    return Challenge(
      name: "double testing challenge",
      description: "test description",
      challengeMode: "map",
      rounds: [Round(initialGeoLocation: GeoUtils.randomSFLocation(), expectedAnswerIndex: nil, allOptions: nil), Round(initialGeoLocation: GeoUtils.randomSFLocation(), expectedAnswerIndex: nil, allOptions: nil)]
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
  
  func generateNewCityChallenge() -> Challenge? {
    guard let top5000Cities = self.top5000Cities else {
      return nil
    }
    let rounds = generateRoundsForCityChallenge(cityPool: top5000Cities, amount: 5)
    return Challenge(
      name: "city challenge",
      description: "5 rounds of city challenge",
      challengeMode: "multipleChoice",
      rounds: rounds)
  }
  
  func generateRoundsForCityChallenge(cityPool: [City], amount: Int) -> [Round]{
    var rounds = [Round]()
    let answerIndexForEachRound = generateRandomNumbers(range: cityPool.count, amount: amount, exception: nil)
    print(answerIndexForEachRound)
    for index in answerIndexForEachRound {
      let city = cityPool[index]
      let coordinate = CLLocationCoordinate2D(latitude: city.latitude, longitude: city.longitude)
      let allOptions = generateOptionsForEachRound(cityPool: cityPool, expectedAnswerIndexInCityPool: index).shuffled()
      let expectedAnswerIndex = allOptions.index(of: city)
      let round = Round(initialGeoLocation: coordinate, expectedAnswerIndex: expectedAnswerIndex, allOptions: allOptions)
      rounds.append(round)
    }
    return rounds
  }
  
  func generateOptionsForEachRound(cityPool: [City], expectedAnswerIndexInCityPool: Int) -> [City] {
    var allOptions = [City]()
    var allOptionIndexesInCityPool = generateRandomNumbers(range: cityPool.count, amount: 3, exception: expectedAnswerIndexInCityPool)
    allOptionIndexesInCityPool.append(expectedAnswerIndexInCityPool)
    for index in allOptionIndexesInCityPool {
      allOptions.append(cityPool[index])
    }
    return allOptions
  }
  
  func generateRandomNumbers(range: Int, amount: Int, exception: Int?) -> [Int] {
    var selectedNumbers = [Int]()
    for _ in 1...amount {
      var newNumber = Int(arc4random_uniform(UInt32(range)))
      if exception != nil {
        while selectedNumbers.contains(newNumber) || exception! == newNumber {
          newNumber = Int(arc4random_uniform(UInt32(range)))
        }
      } else {
        while selectedNumbers.contains(newNumber) {
          newNumber = Int(arc4random_uniform(UInt32(range)))
        }
      }
      selectedNumbers.append(newNumber)
    }
    return selectedNumbers
  }

  static var shared: ChallengeManager = {
    return ChallengeManager()
  }()
}
