//
//  TweetsViewController.swift
//  twitter
//
//  Created by Wanda Cheung on 10/8/14.
//

import UIKit

@objc
protocol TweetsViewControllerDelegate {
  optional func toggleLeftPanel()
  optional func toggleRightPanel()
  optional func collapseSidePanels()
}

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!

  var tweets: [Tweet]?
  var delegate: TweetsViewControllerDelegate?
  
    override func viewDidLoad() {
        super.viewDidLoad()

      tableView.delegate = self
      tableView.dataSource = self
      tableView.rowHeight = UITableViewAutomaticDimension

      
      NSNotificationCenter.defaultCenter().addObserverForName(TwitterEvent.TweetPosted, object: nil, queue: nil) { (notification: NSNotification!) -> Void in
          let tweet = notification.object as Tweet
          self.tweets?.insert(tweet, atIndex: 0)
          self.tableView.reloadData()
      }
        self.loadTweets()
    }
  
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    
        self.tableView.addPullToRefreshWithActionHandler {
            TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: {(tweets, error) -> () in
                self.loadTweets()
            })
        }
    }
  
    func loadTweets() {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            if self.tableView.pullToRefreshView != nil {
                self.tableView.pullToRefreshView.stopAnimating()
            }
            self.tweets = tweets
            self.tableView.reloadData()
          
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                return ()
            })
        })
    }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("tweetCell") as TweetViewCell
    
          let tweet = self.tweets?[indexPath.row]
    
          cell.profileImage.setImageWithURL(tweet?.user.profileImageUrl)
          cell.nameLabel.text = tweet?.user.name
          cell.screennameLabel.text = "@\(tweet!.user.screenname)"
          cell.tweetLabel.text = tweet?.text
          cell.timeLabel.text = tweet?.createdAt.timeAgo()
          return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let storyboard = UIStoryboard(name: "NewMain", bundle: NSBundle.mainBundle())
    let controller = storyboard.instantiateViewControllerWithIdentifier("TweetDetail") as TweetDetailViewController
      controller.tweet = self.tweets![indexPath.row]
      self.navigationController?.pushViewController(controller, animated: true)
    }

  
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 200
  }
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.tweets?.count ?? 0
  }
  
  @IBAction func onMenuTap(sender: AnyObject) {
    println("in onMenuTap")
    if let d = delegate {
      println("in if function of onMenuTap")
      d.toggleLeftPanel?()
    }
  }

}
