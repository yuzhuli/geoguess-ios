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
    streetViewController.delegate = self
    navigationController = UINavigationController(rootViewController: streetViewController)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
  
  private var currentRoundIndex = 0
  private let challenge: Challenge
  private weak var window: UIWindow?
  private var navigationController: UINavigationController!
}

extension ChallengeCoordinator: StreetViewControllerDelegate {
  func didPressGuessButton(viewController: StreetViewController) {
    let mapViewController = MapViewController(expectedCoordinate: challenge.rounds[currentRoundIndex].initialGeoLocation)
    mapViewController.delegate = self
    navigationController.pushViewController(mapViewController, animated: true)
  }
}

extension ChallengeCoordinator: MapViewControllerDelegate {
  func didPressNextRoundButton(viewController: MapViewController) {
    currentRoundIndex += 1
    let streetViewController = StreetViewController(initialGeoLocation: challenge.rounds[currentRoundIndex].initialGeoLocation)
    streetViewController.delegate = self
    navigationController.pushViewController(streetViewController, animated: true)
  }
}
