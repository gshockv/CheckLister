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
    
    private let ITEM_ID_KEY = "itemId"
    private let TEXT_KEY = "text"
    private let CHECKED_KEY = "checked"
    private let DUE_DATE_KEY = "dueDate"
    private let SHOULD_REMIND_KEY = "shouldRemind"
    
    var itemID: Int
    var text = ""
    var checked = false
    var dueDate = NSDate()
    var shouldRemind = false
    
    required init?(coder aDecoder: NSCoder) {
        itemID = aDecoder.decodeIntegerForKey(ITEM_ID_KEY)
        text = aDecoder.decodeObjectForKey(TEXT_KEY) as! String
        checked = aDecoder.decodeBoolForKey(CHECKED_KEY)
        dueDate = aDecoder.decodeObjectForKey(DUE_DATE_KEY) as! NSDate
        shouldRemind = aDecoder.decodeBoolForKey(SHOULD_REMIND_KEY)
        
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
            UIApplication.sharedApplication().cancelLocalNotification(notification)
        }
        
        if shouldRemind && dueDate.compare(NSDate()) != .OrderedAscending {
            let localNotification = UILocalNotification()
            localNotification.fireDate = dueDate
            localNotification.timeZone = NSTimeZone.defaultTimeZone()
            localNotification.alertBody = text
            localNotification.soundName = UILocalNotificationDefaultSoundName
            localNotification.userInfo = ["ItemID" : itemID]
            
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        }
    }
    
    func notificationForThisItem() -> UILocalNotification? {
        let allNotifications = UIApplication.sharedApplication().scheduledLocalNotifications!
        
        for notification in allNotifications {
            if let number = notification.userInfo?["ItemID"] as? Int where number == itemID {
                return notification
            }
        }
        return nil
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(itemID, forKey: ITEM_ID_KEY)
        aCoder.encodeObject(text, forKey: TEXT_KEY)
        aCoder.encodeBool(checked, forKey: CHECKED_KEY)
        aCoder.encodeObject(dueDate, forKey: DUE_DATE_KEY)
        aCoder.encodeBool(shouldRemind, forKey: SHOULD_REMIND_KEY)
    }
    
    deinit {
        if let notification = notificationForThisItem() {
            UIApplication.sharedApplication().cancelLocalNotification(notification)
        }
    }
    
}
