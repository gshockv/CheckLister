//
//  ChecklistItem.swift
//  CheckLister
//
//  Created by Vitaly Gashock on 6/22/16.
//  Copyright © 2016 Vitaly Gashock. All rights reserved.
//

import Foundation
import UIKit

class ChecklistItem: NSObject, NSCoding {
    
    fileprivate let ITEM_ID_KEY = "itemId"
    fileprivate let TEXT_KEY = "text"
    fileprivate let CHECKED_KEY = "checked"
    fileprivate let DUE_DATE_KEY = "dueDate"
    fileprivate let SHOULD_REMIND_KEY = "shouldRemind"
    
    var itemID: Int
    var text = ""
    var checked = false
    var dueDate = Date()
    var shouldRemind = false
    
    required init?(coder aDecoder: NSCoder) {
        itemID = aDecoder.decodeInteger(forKey: ITEM_ID_KEY)
        text = aDecoder.decodeObject(forKey: TEXT_KEY) as! String
        checked = aDecoder.decodeBool(forKey: CHECKED_KEY)
        dueDate = aDecoder.decodeObject(forKey: DUE_DATE_KEY) as! Date
        shouldRemind = aDecoder.decodeBool(forKey: SHOULD_REMIND_KEY)
        
        super.init()
    }
    
    override init() {
        itemID = DataModel.nextChecklistItemId()
        super.init()
    }
    
    func toggleChecked() {
        checked = !checked
    }
    
    func scheduleNotification() {
        if let notification = notificationForThisItem() {
            UIApplication.shared.cancelLocalNotification(notification)
        }
        
        if shouldRemind && dueDate.compare(Date()) != .orderedAscending {
            let localNotification = UILocalNotification()
            localNotification.fireDate = dueDate
            localNotification.timeZone = TimeZone.current
            localNotification.alertBody = text
            localNotification.soundName = UILocalNotificationDefaultSoundName
            localNotification.userInfo = ["ItemID" : itemID]
            
            UIApplication.shared.scheduleLocalNotification(localNotification)
        }
    }
    
    func notificationForThisItem() -> UILocalNotification? {
        let allNotifications = UIApplication.shared.scheduledLocalNotifications!
        
        for notification in allNotifications {
            if let number = notification.userInfo?["ItemID"] as? Int, number == itemID {
                return notification
            }
        }
        return nil
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(itemID, forKey: ITEM_ID_KEY)
        aCoder.encode(text, forKey: TEXT_KEY)
        aCoder.encode(checked, forKey: CHECKED_KEY)
        aCoder.encode(dueDate, forKey: DUE_DATE_KEY)
        aCoder.encode(shouldRemind, forKey: SHOULD_REMIND_KEY)
    }
    
    deinit {
        if let notification = notificationForThisItem() {
            UIApplication.shared.cancelLocalNotification(notification)
        }
    }
    
}
