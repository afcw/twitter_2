//
//  MenuViewController.swift
//  twitter
//
//  Created by Wanda Cheung on 10/17/14.
//  Copyright (c) 2014 Wanda Cheung. All rights reserved.
//

import UIKit


class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  @IBOutlet weak var tableView: UITableView!
  var menuItems: Array<MenuItem>!
  
  struct TableView {
      struct CellIdentifiers {
          static let MenuCell = "MenuCell"
      }
  }
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      println("in MenuViewController")
      
      tableView.reloadData()
      
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        println("number of sections")
        return 1
    }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    println("number of menu items: \(menuItems.count)")
    return menuItems.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell") as MenuCell
    
      let menuItem = self.menuItems?[indexPath.row]
      cell.menuItemLabel.text = menuItem?.title
      return cell
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
