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

private let cityChallengeResultCollectionViewCell = "cityChallengeResultCollectionViewCell"

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
    resultCollectionView.dataSource = self
    resultCollectionView.register(
      UINib(nibName: "CityChallengeResultCollectionViewCell", bundle: nil),
      forCellWithReuseIdentifier: cityChallengeResultCollectionViewCell)
    view.setGradientBackground(colorOne: UIColor.PurpleBlue, colorTwo: UIColor.GreenBlue, colorThree: UIColor.PurpleBlue)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    resultCollectionView.collectionViewLayout = LayoutSingleColumn
  }
  
  @IBAction func onExitButtonPressed(_ sender: Any) {
    delegate?.didPressOnExitButton(viewController: self)
  }
  
  @IBOutlet weak var resultCollectionView: UICollectionView!
  @IBOutlet weak var exitButton: UIButton!
  weak var delegate: ResultViewControllerDelegate?
  
  var LayoutSingleColumn: UICollectionViewFlowLayout {
    let layout = UICollectionViewFlowLayout()
    let width = resultCollectionView.frame.width - 20
    let height: CGFloat = 56
    layout.itemSize = CGSize(width: width, height: height)
    layout.minimumInteritemSpacing = 8
    layout.minimumLineSpacing = 8
    layout.headerReferenceSize = CGSize(width: 0, height: 0)
    layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    return layout
  }
  
  private let challenge: Challenge!
  private let userSelectedCoordinates: [CLLocationCoordinate2D]!
  private let userSelectedCities: [City]?
}

extension ResultViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return challenge.rounds.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cityChallengeResultCollectionViewCell, for: indexPath) as! CityChallengeResultCollectionViewCell
    cell.roundNumber.text = "\(indexPath.row + 1)"
    cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    cell.layer.cornerRadius = 10
    cell.layer.borderWidth = 1.0
    cell.layer.borderColor = UIColor.clear.cgColor
    cell.layer.masksToBounds = true
    
    if challenge.challengeMode == "map" {
      let initialGeolocation = self.challenge.rounds[indexPath.row].initialGeoLocation
      let initialGeolocationCLLocation = CLLocation(latitude: initialGeolocation.latitude, longitude: initialGeolocation.longitude)
      let userSelectedCoordinateCLLocation = CLLocation(latitude: userSelectedCoordinates[indexPath.row].latitude, longitude: userSelectedCoordinates[indexPath.row].longitude)
      let distance = initialGeolocationCLLocation.distance(from: userSelectedCoordinateCLLocation)
      let distanceInKM = distance / 1000
      let roundedDistanceInKM = Double(round(100 * distanceInKM) / 100)
      cell.expectedAnswer.text = "\(roundedDistanceInKM)"
    }
    if challenge.challengeMode == "multipleChoice" {
      let userSelectedCity = userSelectedCities![indexPath.row]
      let expectedAnswerIndex = challenge.rounds[indexPath.row].expectedAnswerIndex
      let expectedAnswer = challenge.rounds[indexPath.row].allOptions![expectedAnswerIndex!]
      if userSelectedCity == expectedAnswer {
        //cell.cityChallengeCellImageView.image = UIImage(named: "checkMark")
        cell.markImage.image = #imageLiteral(resourceName: "checkMark")
      } else {
        cell.markImage.image = #imageLiteral(resourceName: "crossMark")
      }
      cell.expectedAnswer.text = "Expected: \(expectedAnswer.cityName!) \(expectedAnswer.country!)"
      cell.userSelectedAnswer.text = "Your Answer: \(userSelectedCity.cityName!) \(userSelectedCity.country!)"
    }
    
    return cell
  }
}

//extension ResultViewController: UITableViewDataSource {
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    var rows: Int
//    if challenge.challengeMode == "map" {
//      rows = self.userSelectedCoordinates.count
//    } else {
//      rows = self.userSelectedCities!.count
//    }
//    return rows
//  }
//}
