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

protocol StreetViewControllerDelegate: class {
  func didPressGuessButton(viewController: StreetViewController)
}

class StreetViewController: UIViewController, GMSMapViewDelegate {
  
  init(initialGeoLocation: CLLocationCoordinate2D) {
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
//    let panoView = GMSPanoramaView(frame: .zero)
//    self.view = panoView
//    panoView.delegate = self
//    panoView.moveNearCoordinate(CLLocationCoordinate2D(latitude: 37.3317134, longitude: -122.0307466))
  }
  
  weak var delegate: StreetViewControllerDelegate?
    
  private func setUpGuessButton() {
    guessButton = UIButton(frame: CGRect(
      x: view.frame.size.width / 2 - 100,
      y: view.frame.size.height - 88,
      width: 224,
      height: 24))
    guessButton.layer.cornerRadius = 10
    guessButton.clipsToBounds = true
    let guessButtonColor = UIColor(red:0.50, green:0.07, blue:0.20, alpha:1.0)
    guessButton.backgroundColor = guessButtonColor
    guessButton.setTitle("I know where this is!", for: .normal)
    guessButton.addTarget(
      self,
      action: #selector(StreetViewController.onGuessButtonPressed(_:)),
      for: .touchUpInside)
    view.addSubview(guessButton)
    view.bringSubviewToFront(guessButton)
  }
  
  @objc private func onGuessButtonPressed(_ sender: UIButton!) {
    delegate?.didPressGuessButton(viewController: self)
  }
  
  private var guessButton: UIButton!
  
  private let initialGeoLocation: CLLocationCoordinate2D
}


extension StreetViewController: GMSPanoramaViewDelegate {
    func panoramaView(_ view: GMSPanoramaView, error: Error, onMoveNearCoordinate coordinate: CLLocationCoordinate2D) {
        print(error.localizedDescription)
    }
}
