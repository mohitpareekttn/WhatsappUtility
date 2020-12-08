//
//  AppDelegate.swift
//  Whatsapp utility demo
//
//  Created by MOHIT PAREEK on 05/11/20.
//  Copyright © 2020 MOHIT PAREEK. All rights reserved.
//

import UIKit
import CoreData
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if (UserDefaults.standard.bool(forKey: "HasLaunchedOnce")) {
           // App already launched
            print("Not The First Launch")

        } else {
           // This is the first launch ever
            print("First Launch")
            UserDefaults.standard.setValue(0, forKey: "messageCounter")
            UserDefaults.standard.setValue(0, forKey: "historyCounter")
            addDefaultValuesInCoreData()
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            
            UserDefaults.standard.synchronize()
            
            
            
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataManager.sharedManager.saveData()
    }

    func addDefaultValuesInCoreData() {
        
        CoreDataManager.sharedManager.createMessage(title: "Hi", message: "Hi")
        CoreDataManager.sharedManager.createMessage(title: "Hello", message: "Hello")
        CoreDataManager.sharedManager.createMessage(title: "Hey", message: "Hey!")
    }

}

