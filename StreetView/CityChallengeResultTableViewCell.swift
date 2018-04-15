//
//  CityChallengeResultTableViewCell.swift
//  StreetView
//
//  Created by LiYuzhu on 4/10/18.
//  Copyright © 2018 LiYuzhu. All rights reserved.
//

import UIKit

class CityChallengeResultTableViewCell: UITableViewCell {

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
  
  
  @IBOutlet weak var cityChallengeCellImageView: UIImageView!
  @IBOutlet weak var cityChallengeCellExpected: UILabel!
  @IBOutlet weak var cityChallengeCellUserAnswer: UILabel!
  
}
