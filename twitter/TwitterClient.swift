//
//  TwitterClient.swift
//  twitter
//
//  Created by Wanda Cheung on 10/8/14.
//

import UIKit
let twitterConsumerKey = "YWh6aLZfBNJkYmEvmVsyEo3ZF"
let twitterConsumerSecret = "AIMxPJnaBXpyJEMAeD1pGOf5XboY7KlLxICLUJhLH11a0mbiwI"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
  
  var loginCompletion: ((user: User?, error: NSError?) -> ())?
  
  class var sharedInstance: TwitterClient {
    struct Static {
      static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
    }
    return Static.instance
  }
  
  func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
    self.GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
      var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
      completion(tweets: tweets, error: nil)
      }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
        completion(tweets: nil, error: error)
    })
  }
  
  func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
    loginCompletion = completion
    
    // Fetch request token & redirect to authorization page
    self.requestSerializer.removeAccessToken()
    self.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuthToken!) -> Void in
      println("got request token")
      var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
      UIApplication.sharedApplication().openURL(authURL)
      }) { (error: NSError!) -> Void in
        println("failed to get request token")
        self.loginCompletion?(user: nil, error: error)
    }
  }
  
  
  func postTweetWithParams(params: NSDictionary?, completion: (tweet: Tweet?, error: NSError?) -> ()) {
    self.POST("1.1/statuses/update.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
      var tweet = Tweet(dictionary: response as NSDictionary)
      println("in api with tweet \(tweet)")
      println(response)
      completion(tweet: tweet, error: nil)
      }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
        println("error posting status update")
        completion(tweet: nil, error: error)
    }
  }

  
  func openURL(url: NSURL) {
    fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuthToken(queryString: url.query), success: {(accessToken: BDBOAuthToken!) -> Void in
      println("Got the access token!")
      self.requestSerializer.saveAccessToken(accessToken)
      self.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
        
        var user = User(dictionary: response as NSDictionary)
        User.currentUser = user
        println("user: \(user.name)")
        self.loginCompletion?(user: user, error: nil)
        }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
          println("error getting current user")
          self.loginCompletion?(user: nil, error: error)
        })

    }) { (error: NSError!) -> Void in
      println("Failed to receive access token")
      self.loginCompletion?(user: nil, error: error)
    }
  
  }
}
