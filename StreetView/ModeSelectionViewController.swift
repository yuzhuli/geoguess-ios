//
//  ModeSelectionViewController.swift
//  StreetView
//
//  Created by LiYuzhu on 3/12/18.
//  Copyright © 2018 LiYuzhu. All rights reserved.
//

import UIKit

protocol ModeSelectionViewControllerDelegate: class {
  func didPressStartMapGameButton(viewController: ModeSelectionViewController)
  func didPressCityChallengeButton(viewController: ModeSelectionViewController)
}

class ModeSelectionViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func onCityChallengeButtonPressed(_ sender: Any) {
    delegate?.didPressCityChallengeButton(viewController: self)
  }
  
  @IBAction func onStartMapGameButtonPressed(_ sender: Any) {
    delegate?.didPressStartMapGameButton(viewController: self)
  }
  
  @IBOutlet weak var cityChallenge: UIButton!
  
  @IBOutlet weak var startMapGame: UIButton!
  weak var delegate: ModeSelectionViewControllerDelegate?
}
