//
//  WUTabBarController.swift
//  Whatsapp utility demo
//
//  Created by MOHIT PAREEK on 20/11/20.
//  Copyright © 2020 MOHIT PAREEK. All rights reserved.
//

import UIKit

class WUTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        setUpTabBar()
        
        
    }
    

    
    
    func setUpTabBar() {
        
        
        let homeVC = HomeViewController.instantiate(fromAppStoryboard: .WUHomeStoryBoard)
        let homeViewController = UINavigationController(rootViewController: homeVC!)
//        homeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        homeViewController.tabBarItem = UITabBarItem(title: "Compose", image: UIImage(named: "compose_filled"), tag: 0)
        
        
        
        
        let historyVC = HistoryViewController.instantiate(fromAppStoryboard: .WUHistoryStoryBoard)
        let historyViewController = UINavigationController(rootViewController: historyVC!)
        historyViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        
        
        let customVC = CustomSavedMessagesViewController.instantiate(fromAppStoryboard: .CustomMessageStoryBoard)
        let customMessagesViewController = UINavigationController(rootViewController: customVC!)
        customMessagesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        
        let settingsVC = FeaturedViewController.instantiate(fromAppStoryboard: .FeaturedStoryBoard)
        
        let settingsViewController = UINavigationController(rootViewController: settingsVC!)
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings_filled"), tag: 3)

        
        
        let viewControllers = [homeViewController, historyViewController, customMessagesViewController, settingsViewController]
        
        self.viewControllers = viewControllers
        
//        self.tabBarController?.tabBar.barTintColor = UIColor(red: 67, green: 242, blue: 132, alpha: 1.0)
        self.tabBar.barTintColor = Colors.appThemeColor
        self.tabBar.tintColor = .white
        
        self.tabBar.unselectedItemTintColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        
    }

}


