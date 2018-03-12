//
//  ResultViewController.swift
//  StreetView
//
//  Created by LiYuzhu on 3/7/18.
//  Copyright © 2018 LiYuzhu. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

private let ResultTableViewCellIdentifier = "ResultTableViewCellIdentifier"

class ResultViewController: UIViewController {

  
  init(challenge: Challenge, userSelectedCoordinates: [CLLocationCoordinate2D]) {
    self.challenge = challenge
    self.userSelectedCoordinates = userSelectedCoordinates
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var resultTableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    resultTableView.dataSource = self
    resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: ResultTableViewCellIdentifier)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  private let challenge: Challenge!
  private let userSelectedCoordinates: [CLLocationCoordinate2D]!
}

extension ResultViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.userSelectedCoordinates.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCellIdentifier)!
    let initialGeolocation = self.challenge.rounds[indexPath.row].initialGeoLocation
    let initialGeolocationCLLocation = CLLocation(latitude: initialGeolocation.latitude, longitude: initialGeolocation.longitude)
    let userSelectedCoordinateCLLocation = CLLocation(latitude: userSelectedCoordinates[indexPath.row].latitude, longitude: userSelectedCoordinates[indexPath.row].longitude)
    let distance = initialGeolocationCLLocation.distance(from: userSelectedCoordinateCLLocation)
    let distanceInKM = distance / 1000
    let roundedDistanceInKM = Double(round(100 * distanceInKM) / 100)
    cell.textLabel?.text = "Round \(indexPath.row): \(roundedDistanceInKM)"
    return cell
  }
}
