//
//  ComposeViewController.swift
//  twitter
//
//  Created by Wanda Cheung on 10/9/14.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

  let MAX_CHARACTERS_ALLOWED = 140
  
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var screennameLabel: UILabel!
  @IBOutlet weak var charCountLabel: UILabel!
  @IBOutlet weak var tweetTextView: UITextView!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

      self.profileImage.setImageWithURL(User.currentUser?.profileImageUrl)
      self.profileImage.layer.cornerRadius = 9.0
      self.profileImage.layer.masksToBounds = true
      self.nameLabel.text = User.currentUser?.name
      self.screennameLabel.text = "@\(User.currentUser!.screenname)"
      
      NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardDidShowNotification, object: nil, queue: nil) { (notification: NSNotification!) -> Void in
        let userInfo = notification.userInfo!
        let keyboardFrameEnd = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
        self.view.frame = CGRectMake(0, 0, keyboardFrameEnd.size.width, keyboardFrameEnd.origin.y)
      }
      
      NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardDidHideNotification, object: nil, queue: nil) { (notification: NSNotification!) -> Void in
        let userInfo = notification.userInfo!
        let keyboardFrameEnd = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
        self.view.frame = CGRectMake(0, 0, keyboardFrameEnd.size.width, keyboardFrameEnd.origin.y)
      }      
      self.charCountLabel.text = "\(MAX_CHARACTERS_ALLOWED) remaining"
      self.tweetTextView.becomeFirstResponder()
  }

  func textViewDidChange(textView: UITextView) {
    let tweet = tweetTextView.text
    let charactersRemaining = MAX_CHARACTERS_ALLOWED - countElements(tweet)
    self.charCountLabel.text = "\(charactersRemaining)"
    self.charCountLabel.textColor = charactersRemaining >= 0 ? .lightGrayColor() : .redColor()
  }

  
  func postTweet(tweet: NSString, params: NSDictionary?) {
    TwitterClient.sharedInstance.postTweetWithParams(params, completion: { (tweet, error) -> () in
      if error != nil {
        NSLog("error posting tweet: \(error)")
        return
      }
      NSNotificationCenter.defaultCenter().postNotificationName(TwitterEvent.TweetPosted, object: tweet)
      self.dismissViewControllerAnimated(true, completion: nil)
    })
  }

  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func onTweetTap(sender: AnyObject) {
      let tweet = self.tweetTextView.text
    if (countElements(tweet) == 0) {
      return
    }
    
    var params: NSDictionary = ["status": tweet]
    
    self.postTweet(tweet, params: params)
  }

  @IBAction func onCancel(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
    
    
  }
  

}
