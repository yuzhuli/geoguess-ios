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
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(expectedCoordinate: CLLocationCoordinate2D) {
    self.expectedCoordinate = expectedCoordinate
    
    super.init(nibName: nil, bundle: nil)
  }
  
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
    mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    view = mapView

    mapView.delegate = self
  }
  
  private func showConfirmButton() {
    confirmButton = UIButton(frame: CGRect(
      x: view.frame.size.width - 50,
      y: view.frame.size.height - 50,
      width: 50,
      height: 50))
    confirmButton.backgroundColor = UIColor.green
    confirmButton.titleLabel?.text = "Confirm"
    confirmButton.addTarget(
      self,
      action: #selector(MapViewController.onConfirmButtonPressed(_:)),
      for: .touchUpInside)
    view.addSubview(confirmButton)
    view.bringSubview(toFront: confirmButton)
  }
  
  private func showCancelButton() {
    cancelButton = UIButton(frame: CGRect(
      x: view.frame.size.width - 100,
      y: view.frame.size.height - 50,
      width: 50,
      height: 50))
    cancelButton.backgroundColor = UIColor.black
    cancelButton.titleLabel?.text = "Cancel"
    cancelButton.addTarget(
      self,
      action: #selector(MapViewController.onCancelButtonPressed(_:)),
      for: .touchUpInside)
    view.addSubview(cancelButton)
    view.bringSubview(toFront: cancelButton)
  }
  
  private func addExpectedMarker() {
    let expectedMarker = GMSMarker(position: expectedCoordinate)
    expectedMarker.title = "Expected position"
    expectedMarker.map = mapView
  }
  
  private func drawPolyline() {
    let path = GMSMutablePath()
    path.add(expectedCoordinate)
    path.add(userSelectedCoordinate)
    let polyline = GMSPolyline(path: path)
    polyline.map = mapView
  }
  
  private func removeButton(button: UIButton) {
    button.removeFromSuperview()
  }
  
  @objc private func onConfirmButtonPressed(_ sender: UIButton!) {
    isCoordinateConfirmed = true
    navigationItem.hidesBackButton = true
    addExpectedMarker()
    drawPolyline()
    removeButton(button: cancelButton)
    removeButton(button: confirmButton)
  }
  
  @objc private func onCancelButtonPressed(_ sender: UIButton!) {
    marker?.map = nil
    removeButton(button: cancelButton)
    removeButton(button: confirmButton)
  }
  
  private let expectedCoordinate: CLLocationCoordinate2D
  private var mapView: GMSMapView!
  private var marker: GMSMarker?
  private var userSelectedCoordinate: CLLocationCoordinate2D!
  private var isCoordinateConfirmed: Bool = false
  private var cancelButton: UIButton!
  private var confirmButton: UIButton!
}

extension MapViewController: GMSMapViewDelegate {
  func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
    guard isCoordinateConfirmed == false else { return }
    
    marker?.map = nil
    
    userSelectedCoordinate = coordinate
    marker = GMSMarker(position: coordinate)
    marker?.title = "Selected position"
    marker?.map = mapView
    showConfirmButton()
    showCancelButton()
  }
}
