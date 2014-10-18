//
//  Tweet.swift
//  twitter
//
//  Created by Wanda Cheung on 10/8/14.
//

import UIKit

class Tweet: NSObject {
  var user: User
  var text: String
  var createdAtString: String
  var createdAt: NSDate
  var numberOfRetweets: Int
  var numberOfFavorites: Int

  init(dictionary: NSDictionary) {
    user = User(dictionary: dictionary["user"] as NSDictionary)
    text = dictionary["text"] as String
    createdAtString = dictionary["created_at"] as String
    
    var formatter = NSDateFormatter()
    formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
    createdAt = formatter.dateFromString(createdAtString)!
   
    numberOfRetweets = dictionary["retweet_count"] as Int
    numberOfFavorites = dictionary["favorite_count"] as Int
    
  }
  
  class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
    var tweets = [Tweet]()
    
    for dictionary in array {
      tweets.append(Tweet(dictionary: dictionary))
    }
    return tweets
  }
}
