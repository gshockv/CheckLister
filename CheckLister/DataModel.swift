//
//  DataModel.swift
//  CheckLister
//
//  Created by Vitaly Gashock on 6/30/16.
//  Copyright © 2016 Vitaly Gashock. All rights reserved.
//

import Foundation

class DataModel {
    var lists = [Checklist]()
    
    init() {
        loadChecklists()
        registerDefaults()
        handleFirstTime()
    }
    
    // MARK: - Properties
    
    var indexOfSelectedChecklist: Int {
        get {
            return UserDefaults.standard.integer(forKey: "ChecklistIndex")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
        }
    }
    
    // MARK: - Items related methods
    
    func loadChecklists() {
        let path = dataFilePath()
        if FileManager.default.fileExists(atPath: path) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                lists = unarchiver.decodeObject(forKey: "Checklists") as! [Checklist]
                unarchiver.finishDecoding()
                
                sortChecklists()
            }
        }
    }
    
    func saveChecklists() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(lists, forKey: "Checklists")
        archiver.finishEncoding()
        data.write(toFile: dataFilePath(), atomically: true)
    }
    
    func sortChecklists() {
        lists.sort(by: { checklist1, checklist2 in return checklist1.name.localizedStandardCompare(checklist2.name) == .orderedAscending})
    }
    
    class func nextChecklistItemId() -> Int {
        let userDefaults = UserDefaults.standard
        let itemID = userDefaults.integer(forKey: "ChecklistItemID")
        userDefaults.set(itemID + 1, forKey: "ChecklistItemID")
        userDefaults.synchronize()
        return itemID
    }
    
    // MARK: - Utils
    
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths[0]
    }
    
    func dataFilePath() -> String {
        return (documentsDirectory() as NSString).appendingPathComponent("Checklists.plist")
    }
    
    // MARK: - Handle User defaults
    
    func handleFirstTime() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
        if firstTime {
            let firstTimeChecklist = Checklist(name: "Default Checklist")
            lists.append(firstTimeChecklist)
            indexOfSelectedChecklist = 0
            userDefaults.set(false, forKey: "FirstTime")
            userDefaults.synchronize()
            
        }
    }
    
    func registerDefaults() {
        let dict = [ "ChecklistIndex" : -1,
                     "FirstTime" : true,
                     "ChecklistItemID" : 0 ] as [String : Any]
        UserDefaults.standard.register(defaults: dict)
    }
}
