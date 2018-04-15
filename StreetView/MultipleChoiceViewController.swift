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
    self.questionLabel.textColor = UIColor.Tiffany
    self.resultLabel.isHidden = true
    self.submitButton.isEnabled = false
    self.nextRoundButton.isHidden = true
    self.nextRoundButton.isEnabled = false
    for (index, option) in allOptions.enumerated() {
      let title = "\(option.cityName!), \(option.country!)"
      choiceButtons[index].setTitle(title, for: .normal)
      setToButtonWithFrame(button: choiceButtons[index], color: UIColor.Tiffany)
    }
  }
  
  @IBAction func selectAnOption(_ sender: UIButton) {
    if let userSelectedAnswerIndex = userSelectedAnswerIndex {
      setToButtonWithFrame(button: choiceButtons[userSelectedAnswerIndex], color: UIColor.Tiffany)
    }
    
    userSelectedAnswerIndex = sender.tag
    setToButtonNoFrame(button: choiceButtons[userSelectedAnswerIndex!], color: UIColor.Tiffany)
    setToButtonNoFrame(button: submitButton, color: UIColor.Burgundy)
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
    submitButton.isHidden = true
    
    if expectedAnswerIndex == userSelectedAnswerIndex {
      resultLabel.text = "You're Right!"
//      for (index, button) in choiceButtons.enumerated() {
//        if index == expectedAnswerIndex {
//          setToButtonWithFrame(button: button, color: UIColor.green)
//        } else {
//          setToButtonWithFrame(button: button, color: UIColor.lightGray)
//        }
//      }
    } else {
      resultLabel.text = "Almost...\nAnswer is: \(allOptions[expectedAnswerIndex].cityName!), \(allOptions[expectedAnswerIndex].country!)"
//      for (index, button) in choiceButtons.enumerated() {
//        if index == expectedAnswerIndex {
//          setToButtonWithFrame(button: button, color: UIColor.green)
//        } else if index == userSelectedAnswerIndex {
//          setToButtonWithFrame(button: button, color: UIColor.red)
//        } else {
//          setToButtonWithFrame(button: button, color: UIColor.lightGray)
//        }
//      }
    }

    resultLabel.textColor = UIColor.Tiffany
    resultLabel.isHidden = false
    setToButtonNoFrame(button: nextRoundButton, color: UIColor.Burgundy)
    nextRoundButton.isHidden = false
    nextRoundButton.isEnabled = true
    delegate?.multipleChoiceViewController(self, didSelect: allOptions[userSelectedAnswerIndex])
  }
  
  @IBAction func onNextRoundButtonPressed(_ sender: UIButton) {
    delegate?.didPressNextRoundButton(viewController: self)
  }
  
  private func setToButtonWithFrame(button: UIButton, color: UIColor) {
    button.layer.cornerRadius = 10
    button.clipsToBounds = true
    button.backgroundColor = UIColor.white
    button.setTitleColor(color, for: .normal)
    button.layer.borderWidth = 1.0
    button.layer.borderColor = color.cgColor
  }
  
  private func setToButtonNoFrame(button: UIButton, color: UIColor) {
    button.layer.cornerRadius = 10
    button.clipsToBounds = true
    button.backgroundColor = color
    button.setTitleColor(UIColor.white, for: .normal)
  }
  
  weak var delegate: MultipleChoiceViewControllerDelegate?
  @IBOutlet weak var resultLabel: UILabel!
  @IBOutlet weak var submitButton: UIButton!
  @IBOutlet var choiceButtons: [UIButton]!
  @IBOutlet weak var nextRoundButton: UIButton!
  @IBOutlet weak var questionLabel: UILabel!
  
  
  private var userSelectedAnswerIndex: Int?
  private var expectedAnswerIndex: Int
  private var allOptions: [City]
  
}

