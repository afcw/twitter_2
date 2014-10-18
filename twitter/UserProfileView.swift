//
//  UserProfileView.swift
//  twitter
//
//  Created by Wanda Cheung on 10/14/14.
//  Copyright (c) 2014 Wanda Cheung. All rights reserved.
//

import UIKit

class UserProfileView: UIView {

  @IBOutlet weak var screenname: UILabel!
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var followingCountLabel: UILabel!
  @IBOutlet var contentView: UserProfileView!
  @IBOutlet weak var followerCountLabel: UILabel!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    var nib = UINib(nibName: "UserProfileView", bundle: nil)
    nib.instantiateWithOwner(self, options: nil)
    contentView.frame = bounds
    addSubview(contentView)
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}
