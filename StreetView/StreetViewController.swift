//
//  StreetViewController.swift
//  StreetView
//
//  Created by LiYuzhu on 2/3/18.
//  Copyright © 2018 LiYuzhu. All rights reserved.
//

import Foundation

import UIKit
import GoogleMaps
import GooglePlaces

class StreetViewController: UIViewController, GMSMapViewDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let panoView = GMSPanoramaView(frame: self.view.frame)
    view.addSubview(panoView)
    panoView.moveNearCoordinate(CLLocationCoordinate2D(latitude: -33.732, longitude: 150.312))
    setUpGuessButton()
  }

  private func setUpGuessButton() {
    guessButton = UIButton(frame: CGRect(
      x: view.frame.size.width - 60,
      y: view.frame.size.height - 50,
      width: 50,
      height: 50))
    guessButton.backgroundColor = UIColor.red
    guessButton.titleLabel?.text = "Guess"
    guessButton.addTarget(
      self,
      action: #selector(StreetViewController.onGuessButtonPressed(_:)),
      for: .touchUpInside)
    view.addSubview(guessButton)
    view.bringSubview(toFront: guessButton)
  }

  @objc private func onGuessButtonPressed(_ sender: UIButton!) {

  }

  private var guessButton: UIButton!

}

