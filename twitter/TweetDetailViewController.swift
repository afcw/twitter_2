//
//  TweetDetailViewController.swift
//  twitter
//
//  Created by Wanda Cheung on 10/9/14.
//

import UIKit

class TweetDetailViewController: UIViewController {

  var tweet: Tweet?
  
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var screennameLabel: UILabel!
  @IBOutlet weak var tweetLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var favoritesCountLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()

      self.navigationItem.title = "Tweet"
      
      self.profileImage.setImageWithURL(self.tweet?.user.profileImageUrl)
      self.profileImage.layer.cornerRadius = 9.0
      self.profileImage.layer.masksToBounds = true
      self.nameLabel.text = self.tweet?.user.name
      self.screennameLabel.text = "@\(self.tweet!.user.screenname)"
      self.tweetLabel.text = self.tweet?.text
      
      var formatter = NSDateFormatter()
      formatter.dateFormat = "MMMM dd, yyyy 'at' h:mm aaa"
      self.timeLabel.text = formatter.stringFromDate(self.tweet!.createdAt)
      
      self.retweetCountLabel.text = "\(self.tweet!.numberOfRetweets)"
      self.favoritesCountLabel.text = "\(self.tweet!.numberOfFavorites)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
