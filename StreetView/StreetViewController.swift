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
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func loadView() {
        let panoView = GMSPanoramaView(frame: .zero)
        self.view = panoView
        panoView.moveNearCoordinate(CLLocationCoordinate2D(latitude: -33.732, longitude: 150.312))
    }
}

