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

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        let navigationController = window!.rootViewController as! UINavigationController
        let controller = navigationController.viewControllers[0] as! AllListsViewController
        controller.dataModel = dataModel
        return true
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        print("didReceiveLocalNotification \(notification)")
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        saveData()
    }

    func applicationWillTerminate(application: UIApplication) {
        saveData()
    }
}

