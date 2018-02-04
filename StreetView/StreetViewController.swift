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
    // Do any additional setup after loading the view, typically from a nib.
  }
    
  override func loadView() {
    let panoView = GMSPanoramaView(frame: .zero)
    self.view = panoView
    panoView.moveNearCoordinate(CLLocationCoordinate2D(
      latitude: initialGeoLocation.latitude,
      longitude: initialGeoLocation.longitude))
  }
  
  private let initialGeoLocation: GeoLocation
}

