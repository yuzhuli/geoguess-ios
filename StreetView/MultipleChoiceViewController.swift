//
//  MultipleChoiceViewController.swift
//  StreetView
//
//  Created by LiYuzhu on 3/19/18.
//  Copyright © 2018 LiYuzhu. All rights reserved.
//

import UIKit

protocol MultipleChoiceViewControllerDelegate: class {
  func didPressNextRoundButton(viewController: MultipleChoiceViewController)
  func multipleChoiceViewController(_ multipleChoiceViewController: MultipleChoiceViewController, didSelect city: City)
}

class MultipleChoiceViewController: UIViewController {
  
  init(allOptions: [City], expectedAnswerIndex: Int) {
    self.allOptions = allOptions
    self.expectedAnswerIndex = expectedAnswerIndex
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.resultLabel.isHidden = true
    self.submitButton.isEnabled = false
    self.nextRoundButton.isHidden = true
    self.nextRoundButton.isEnabled = false
    for (index, option) in allOptions.enumerated() {
      let title = "\(option.cityName!), \(option.country!)"
      choiceButtons[index].setTitle(title, for: .normal)
    }
  }
  
  @IBAction func selectAnOption(_ sender: UIButton) {
    if let userSelectedAnswerIndex = userSelectedAnswerIndex {
      choiceButtons[userSelectedAnswerIndex].setTitleColor(UIColor.blue, for: .normal)
    }
    
    userSelectedAnswerIndex = sender.tag
    choiceButtons[userSelectedAnswerIndex!].setTitleColor(UIColor.brown, for: .normal)
    submitButton.isEnabled = true
  }
  
  @IBAction func onSubmitButtonPressed(_ sender: UIButton) {
    guard let userSelectedAnswerIndex = self.userSelectedAnswerIndex else {
      print("user hasn't selected any option")
      return
    }
    for button in choiceButtons {
      button.isEnabled = false
    }
    submitButton.isEnabled = false
    
    if expectedAnswerIndex == userSelectedAnswerIndex {
      resultLabel.text = "Correct."
    } else {
      resultLabel.text = "Wrong. The answer is \(allOptions[expectedAnswerIndex])"
    }
    resultLabel.isHidden = false
    nextRoundButton.isHidden = false
    nextRoundButton.isEnabled = true
    delegate?.multipleChoiceViewController(self, didSelect: allOptions[userSelectedAnswerIndex])
  }
  
  @IBAction func onNextRoundButtonPressed(_ sender: UIButton) {
    delegate?.didPressNextRoundButton(viewController: self)
  }
  
  
  weak var delegate: MultipleChoiceViewControllerDelegate?
  @IBOutlet weak var resultLabel: UILabel!
  @IBOutlet weak var submitButton: UIButton!
  @IBOutlet var choiceButtons: [UIButton]!
  @IBOutlet weak var nextRoundButton: UIButton!
  
  
  private var userSelectedAnswerIndex: Int?
  private var expectedAnswerIndex: Int
  private var allOptions: [City]
  
}

