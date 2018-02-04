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
  
  init(initialGeoLocation: GeoLocation) {
    self.initialGeoLocation = initialGeoLocation
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    let panoView = GMSPanoramaView(frame: self.view.frame)
    view.addSubview(panoView)
    panoView.moveNearCoordinate(CLLocationCoordinate2D(
      latitude: initialGeoLocation.latitude,
      longitude: initialGeoLocation.longitude))
    setUpGuessButton()
  }
    
  private func setUpGuessButton() {
    guessButton = UIButton(frame: CGRect(
      x: view.frame.size.width - 50,
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
  
  private let initialGeoLocation: GeoLocation
}

