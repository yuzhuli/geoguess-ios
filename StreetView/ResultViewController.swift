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
import Charts

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
    setUpPieChart()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    resultCollectionView.collectionViewLayout = LayoutSingleColumn
  }
  
  @IBAction func onExitButtonPressed(_ sender: Any) {
    delegate?.didPressOnExitButton(viewController: self)
  }
  
  @IBOutlet weak var resultCollectionView: UICollectionView!
  @IBOutlet weak var pieChartView: PieChartView!
  @IBOutlet weak var exitButton: UIButton!
  weak var delegate: ResultViewControllerDelegate?
  
  var LayoutSingleColumn: UICollectionViewFlowLayout {
    let layout = UICollectionViewFlowLayout()
    let width = resultCollectionView.frame.width - 20
    let height: CGFloat = 48
    layout.itemSize = CGSize(width: width, height: height)
    layout.minimumInteritemSpacing = 8
    layout.minimumLineSpacing = 8
    layout.headerReferenceSize = CGSize(width: 0, height: 0)
    layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    return layout
  }
  
  private func setUpPieChart() {
    let numOfCorrectAnswers = countCorrectAnswers()
    let numOfWrongAnswers = challenge.rounds.count - numOfCorrectAnswers
    let total = numOfWrongAnswers + numOfCorrectAnswers
    let entry1 = PieChartDataEntry(value: Double(numOfCorrectAnswers), label: "Correct")
    let entry2 = PieChartDataEntry(value: Double(numOfWrongAnswers), label: "Wrong")
    let dataSet = PieChartDataSet(values: [entry1, entry2], label: nil)
    let data = PieChartData(dataSet: dataSet)
    pieChartView.data = data
    
    pieChartView.holeRadiusPercent = 0.95
    
    pieChartView.animate(yAxisDuration: 1.4)
    
    var pieChartColors: [UIColor] = []
    pieChartColors.append(UIColor.white.withAlphaComponent(0.5))
    pieChartColors.append(UIColor.black.withAlphaComponent(0.5))
    dataSet.colors = pieChartColors
    pieChartView.backgroundColor = UIColor.clear
    pieChartView.holeColor = UIColor.clear
    
//    pieChartView.centerText = "\(numOfCorrectAnswers)/\(total)"
    let myAttributes = [
      NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular),
      NSAttributedStringKey.foregroundColor: UIColor.white
    ]
    let myAttributedString = NSAttributedString(string: "\(numOfCorrectAnswers)/\(total)\nCorrect", attributes: myAttributes)
    pieChartView.centerAttributedText = myAttributedString
    
    pieChartView.legend.enabled = false
    pieChartView.chartDescription?.enabled = false
    pieChartView.drawEntryLabelsEnabled = false
    dataSet.drawValuesEnabled = false
    
    pieChartView.notifyDataSetChanged()
  }
  
  private func countCorrectAnswers() -> Int {
    var numOfCorrectAnswers = 0
    for i in 0 ..< challenge.rounds.count {
      let expectedAnswerIndex = challenge.rounds[i].expectedAnswerIndex
      let expectedAnswer = challenge.rounds[i].allOptions![expectedAnswerIndex!]
      if expectedAnswer == userSelectedCities[i] {
        numOfCorrectAnswers += 1
      }
    }
    return numOfCorrectAnswers
  }
  
  private let challenge: Challenge!
  private let userSelectedCoordinates: [CLLocationCoordinate2D]!
  private let userSelectedCities: [City]
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
      let userSelectedCity = userSelectedCities[indexPath.row]
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
