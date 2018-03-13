//
//  ModeSelectionCoordinator.swift
//  StreetView
//
//  Created by LiYuzhu on 3/12/18.
//  Copyright © 2018 LiYuzhu. All rights reserved.
//

import Foundation
import UIKit

final class ModeSelectionCoordinator {
  init(window: UIWindow) {
    self.window = window
  }
  
  func startFlow() {
    guard let window = window else { return }
    
    let modeSelectionViewController = ModeSelectionViewController()
    modeSelectionViewController.delegate = self
    navigationController = UINavigationController(rootViewController: modeSelectionViewController)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
  
  private weak var window: UIWindow?
  private var navigationController: UINavigationController!
  private var challengeCoordinator: ChallengeCoordinator?
}

extension ModeSelectionCoordinator: ModeSelectionViewControllerDelegate {
  func didPressStartMapGameButton(viewController: ModeSelectionViewController) {
    let challenge = ChallengeManager.shared.doubleTestingChallenge
    let challengeCoordinator = ChallengeCoordinator(challenge: challenge, navigationController: navigationController)
    challengeCoordinator.showStreetViewController()
    self.challengeCoordinator = challengeCoordinator
  }
}
