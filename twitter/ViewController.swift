//
//  ViewController.swift
//  twitter
//
//  Created by Wanda Cheung on 10/8/14.
//

import UIKit


class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    println("login page")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  @IBAction func onLogin(sender: AnyObject) {
    TwitterClient.sharedInstance.loginWithCompletion(){
      (user: User?, error: NSError?) in
      if user != nil {
        self.performSegueWithIdentifier("loginSegue", sender: self)
      } else {
        //handle login error
      }
    }
    
  }
    
    
}

