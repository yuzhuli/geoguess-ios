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

protocol ResultViewControllerDelegate: class {
  func didPressOnExitButton(viewController: ResultViewController)
}

private let ResultTableViewCellIdentifier = "cityChallengeResultTableViewCell"

class ResultViewController: UIViewController {

  init(challenge: Challenge, userSelectedCoordinates: [CLLocationCoordinate2D], userSelectedCities: [City]) {
    self.challenge = challenge
    self.userSelectedCoordinates = userSelectedCoordinates
    self.userSelectedCities = userSelectedCities
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    resultTableView.dataSource = self
//    resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: ResultTableViewCellIdentifier)
    resultTableView.register(
      UINib(nibName: "CityChallengeResultTableViewCell", bundle: nil),
      forCellReuseIdentifier: ResultTableViewCellIdentifier)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func onExitButtonPressed(_ sender: Any) {
    delegate?.didPressOnExitButton(viewController: self)
  }
  
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var resultTableView: UITableView!
  @IBOutlet weak var exitButton: UIButton!
  weak var delegate: ResultViewControllerDelegate?
  
  private let challenge: Challenge!
  private let userSelectedCoordinates: [CLLocationCoordinate2D]!
  private let userSelectedCities: [City]?
}

extension ResultViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    var rows: Int
    if challenge.challengeMode == "map" {
      rows = self.userSelectedCoordinates.count
    } else {
      rows = self.userSelectedCities!.count
    }
    return rows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCellIdentifier) as! CityChallengeResultTableViewCell

    if challenge.challengeMode == "map" {
      let initialGeolocation = self.challenge.rounds[indexPath.row].initialGeoLocation
      let initialGeolocationCLLocation = CLLocation(latitude: initialGeolocation.latitude, longitude: initialGeolocation.longitude)
      let userSelectedCoordinateCLLocation = CLLocation(latitude: userSelectedCoordinates[indexPath.row].latitude, longitude: userSelectedCoordinates[indexPath.row].longitude)
      let distance = initialGeolocationCLLocation.distance(from: userSelectedCoordinateCLLocation)
      let distanceInKM = distance / 1000
      let roundedDistanceInKM = Double(round(100 * distanceInKM) / 100)
      cell.textLabel?.text = "Round \(indexPath.row): \(roundedDistanceInKM)"
    }
    if challenge.challengeMode == "multipleChoice" {
      let userSelectedCity = userSelectedCities![indexPath.row]
      let expectedAnswerIndex = challenge.rounds[indexPath.row].expectedAnswerIndex
      let expectedAnswer = challenge.rounds[indexPath.row].allOptions![expectedAnswerIndex!]
      if userSelectedCity == expectedAnswer {
        //cell.cityChallengeCellImageView.image = UIImage(named: "checkMark")
        cell.cityChallengeCellImageView.image = #imageLiteral(resourceName: "checkMark")
      } else {
        cell.cityChallengeCellImageView.image = #imageLiteral(resourceName: "crossMark")
      }
      cell.cityChallengeCellExpected.text = "Expected: \(expectedAnswer.cityName!) \(expectedAnswer.country!)"
      cell.cityChallengeCellUserAnswer.text = "Your Answer: \(userSelectedCity.cityName!) \(userSelectedCity.country!)"
//      cell.cityChallengeCellUserAnswer.font
    }
    return cell
  }
}
