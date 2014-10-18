//
//  TweetViewCell.swift
//  twitter
//
//  Created by Wanda Cheung on 10/8/14.
//

import UIKit

class TweetViewCell: UITableViewCell {
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var screennameLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var tweetLabel: UILabel!
  
  var tweet: Tweet?
  
  override func awakeFromNib() {
      super.awakeFromNib()
        self.profileImage.layer.cornerRadius = 9.0
        self.profileImage.layer.masksToBounds = true

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
