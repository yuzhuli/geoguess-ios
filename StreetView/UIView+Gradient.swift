//
//  UIView+Gradient.swift
//  StreetView
//
//  Created by LiYuzhu on 4/24/18.
//  Copyright © 2018 LiYuzhu. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  func setGradientBackground(colorOne: UIColor, colorTwo: UIColor, colorThree: UIColor) {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = bounds
    gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor, colorThree.cgColor]
    gradientLayer.locations = [0.0, 0.33, 0.66]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    layer.insertSublayer(gradientLayer, at: 0)
  }
}
