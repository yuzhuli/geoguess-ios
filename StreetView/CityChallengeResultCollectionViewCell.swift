//
//  CityChallengeResultCollectionViewCell.swift
//  StreetView
//
//  Created by LiYuzhu on 4/22/18.
//  Copyright © 2018 LiYuzhu. All rights reserved.
//

import UIKit

class CityChallengeResultCollectionViewCell: UICollectionViewCell {

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  

  @IBOutlet weak var expectedAnswer: UILabel!
  @IBOutlet weak var userSelectedAnswer: UILabel!
  @IBOutlet weak var roundNumber: UILabel!
  @IBOutlet weak var markImage: UIImageView!
}
