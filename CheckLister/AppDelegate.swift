//
//  AppDelegate.swift
//  CheckLister
//
//  Created by Vitaly Gashock on 6/21/16.
//  Copyright © 2016 Vitaly Gashock. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   
    var window: UIWindow?
    
    var dataModel = DataModel()
    
    func saveData() {
        dataModel.saveChecklists()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let navigationController = window!.rootViewController as! UINavigationController
        let controller = navigationController.viewControllers[0] as! AllListsViewController
        controller.dataModel = dataModel
        return true
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        print("didReceiveLocalNotification \(notification)")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        saveData()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        saveData()
    }
}

