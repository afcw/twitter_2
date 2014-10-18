//
//  ContainerViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState {
  case BothCollapsed
  case LeftPanelExpanded
  case RightPanelExpanded
}

class ContainerViewController: UIViewController, TweetsViewControllerDelegate {

    var centerNavigationController: UINavigationController!
    var centerViewController: TweetsViewController!
    var currentState: SlideOutState = .BothCollapsed
    var leftViewController: MenuViewController?
  
  let centerPanelExpandedOffset: CGFloat = 60
  

  override init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerViewController = UIStoryboard.centerViewController()
        centerViewController.delegate = self
      
      centerNavigationController = UINavigationController(rootViewController: centerViewController)
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        centerNavigationController.didMoveToParentViewController(self)
    }
  
    // MARK: CenterViewController delegate methods
  
    func toggleLeftPanel() {
      println("in toggleLeftPanel function")
      let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
      println("currentState is \(currentState)")
      if notAlreadyExpanded {
        addLeftPanelViewController()
      }
      println("right before animate LeftPanel")
      animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
  
    func toggleRightPanel() {
    }
  
    func addLeftPanelViewController() {
      println("in addLeftPanelViewController function")
      if (leftViewController == nil) {
          leftViewController = UIStoryboard.leftViewController()
          leftViewController!.menuItems = MenuItem.allMenuItems()
        
          self.addChildSidePanelController(leftViewController!)
      }
    }
    
  func addChildSidePanelController(sidePanelController: MenuViewController) {
    println("in addChildSidePanelController")
    view.insertSubview(sidePanelController.view, atIndex: 0)
    
    addChildViewController(sidePanelController)
    sidePanelController.didMoveToParentViewController(self)
  }
  
//    func addRightPanelViewController() {
//    }
  
    func animateLeftPanel(#shouldExpand: Bool) {
        if (shouldExpand) {
            currentState = .LeftPanelExpanded

          animateCenterPanelXPosition(targetPosition: CGRectGetWidth(centerNavigationController.view.frame) - centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { finished in
              self.currentState = .BothCollapsed
            
              self.leftViewController!.view.removeFromSuperview()
              self.leftViewController = nil;
            }
      }
    }
  
    func animateCenterPanelXPosition(#targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
              self.centerNavigationController.view.frame.origin.x = targetPosition }, completion: completion)
    }
  
    func animateRightPanel(#shouldExpand: Bool) {
    }
  
    // MARK: Gesture recognizer
  
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
    }
}

private extension UIStoryboard {
  class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "NewMain", bundle: NSBundle.mainBundle()) }
  
  class func leftViewController() -> MenuViewController? {
    return mainStoryboard().instantiateViewControllerWithIdentifier("MenuViewController") as? MenuViewController
  }
  
//  class func rightViewController() -> SidePanelViewController? {
//    return mainStoryboard().instantiateViewControllerWithIdentifier("RightViewController") as? SidePanelViewController
//  }
  
  class func centerViewController() -> TweetsViewController? {
    return mainStoryboard().instantiateViewControllerWithIdentifier("TweetsViewController") as? TweetsViewController
  }
}