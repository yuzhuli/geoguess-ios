//
//  ChallengeCoordinator.swift
//  StreetView
//
//  Created by Hongze Zhao on 2/7/18.
//  Copyright © 2018 LiYuzhu. All rights reserved.
//

import Foundation
import GoogleMaps
import UIKit

final class ChallengeCoordinator {
  init(challenge: Challenge, navigationController: UINavigationController) {
    self.challenge = challenge
    self.parentNavigationController = navigationController
  }

  func showStreetViewController() {
    guard let firstRound = challenge.rounds.first else {
      fatalError("Challenge rounds is empty")
    }
    let streetViewController = StreetViewController(initialGeoLocation: firstRound.initialGeoLocation)
    streetViewController.delegate = self
    navigationController = UINavigationController(rootViewController: streetViewController)
    parentNavigationController.present(navigationController, animated: true)
  }
  
  private var currentRoundIndex = 0
  private let challenge: Challenge
  private var parentNavigationController: UINavigationController!
  private var navigationController: UINavigationController!
  private var userSelectedCoordinates = [CLLocationCoordinate2D]()
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
    if currentRoundIndex < challenge.rounds.count {
      let streetViewController = StreetViewController(initialGeoLocation: challenge.rounds[currentRoundIndex].initialGeoLocation)
      streetViewController.delegate = self
      navigationController.pushViewController(streetViewController, animated: true)
      
    }
    else {
      let resultViewController = ResultViewController(challenge: challenge, userSelectedCoordinates: userSelectedCoordinates)
      resultViewController.delegate = self
      navigationController.pushViewController(resultViewController, animated: true)
    }
  }
  
  func mapViewController(_ mapViewController: MapViewController, didSelect coordinate: CLLocationCoordinate2D) {
    userSelectedCoordinates.append(coordinate)
  }
}

extension ChallengeCoordinator: ResultViewControllerDelegate {
  func didPressOnExitButton(viewController: ResultViewController) {
    navigationController.dismiss(animated: true)
  }
}



