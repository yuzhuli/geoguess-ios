//
//  ChallengeCoordinator.swift
//  StreetView
//
//  Created by Hongze Zhao on 2/7/18.
//  Copyright © 2018 LiYuzhu. All rights reserved.
//

import Foundation
import UIKit

final class ChallengeCoordinator {
  init(challenge: Challenge, window: UIWindow?) {
    self.challenge = challenge
    self.window = window
  }

  func startFlow() {
    guard let window = window else { return }

    guard let firstRound = challenge.rounds.first else {
      fatalError("Challenge rounds is empty")
    }

    let streetViewController = StreetViewController(initialGeoLocation: firstRound.initialGeoLocation)
    navigationController = UINavigationController(rootViewController: streetViewController)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }

  private let challenge: Challenge
  private weak var window: UIWindow?
  private var navigationController: UINavigationController!
}

