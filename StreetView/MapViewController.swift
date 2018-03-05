//
//  ViewController.swift
//  StreetView
//
//  Created by LiYuzhu on 1/30/18.
//  Copyright © 2018 LiYuzhu. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func loadView() {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate 0.00, 180.00 at zoom level 0.
    let camera = GMSCameraPosition.camera(
      withLatitude: GeoUtils.initialMapPosition.latitude,
      longitude: GeoUtils.initialMapPosition.longitude,
      zoom: 0.0)
    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    view = mapView
  }
}

