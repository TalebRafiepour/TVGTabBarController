//
//  ViewController.swift
//  TVGTabbarControllerDemo
//
//  Created by Taleb on 9/30/19.
//  Copyright © 2019 Taleb. All rights reserved.
//

import UIKit
import TVGTabBarController

class ViewController: TVGTabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTVGTabBar()
    }
    
    fileprivate func initTVGTabBar() {
        var tabBarItem, tabBarItem2, tabBarItem3, tabBarItem4: TVGTabBarItem
        
        tabBarItem  = TVGTabBarItem(image: UIImage(named: "home")!, title: "Home")
        tabBarItem2 = TVGTabBarItem(image: UIImage(named: "like")!, title: "Like")
        tabBarItem3 = TVGTabBarItem(image: UIImage(named: "favorite")!, title: "Favorite")
        tabBarItem4 = TVGTabBarItem(image: UIImage(named: "profile")!, title: "Profile")
        
        let badge = TVGTabBarBadge(value:3, badgeColor: .red)
        tabBarItem.badge = badge
        
        
        let vc1 = storyboard!.instantiateViewController(identifier: "VC1ViewControlelr")
        let vc2 = storyboard!.instantiateViewController(identifier: "VC2ViewControlelr")
        let vc3 = storyboard!.instantiateViewController(identifier: "VC3ViewControlelr")
        let vc4 = storyboard!.instantiateViewController(identifier: "VC4ViewControlelr")
        
        self.delegate = self
        self.viewControllers = [vc1, vc2, vc3,vc4]
        self.tabBarItems = [tabBarItem,tabBarItem2,tabBarItem3,tabBarItem4]
        //self.tabsBadgeColor = UIColor.blue
        //self.tabsSelectedTintColor = .orange
        //self.tabsDefaultTintColor = .gray
        //self.tabsTitleIsHidden = true
        //self.tabsPointerColor = .orange
        //self.animDurationOfVC = 0.15
        //self.tabbarSize = .normal
        //self.tabPointerStyle = .circle
        //self.tabsFont = UIFont(name: "Arial", size: 14)
        //self.selectedViewController = vc3
    }
}




extension ViewController: TVGTabBarControllerDelegate {
    func tabBarController(_ tabBarController: TVGTabBarController, didSelect: UIViewController) {
        print("Delegate success!");
    }
}
