//
//  MenuItem.swift
//  twitter
//
//  Created by Wanda Cheung on 10/17/14.
//  Copyright (c) 2014 Wanda Cheung. All rights reserved.
//

import UIKit
import Foundation

@objc
class MenuItem {
  
  let title: String
  
  init(title: String) {
    self.title = title
  }
  
  class func allMenuItems() -> Array<MenuItem> {
    return [ MenuItem(title: "Profile"),
      MenuItem(title: "Home Timeline"),
      MenuItem(title: "Mentions"),
      MenuItem(title: "Logout")]
  }
  
}