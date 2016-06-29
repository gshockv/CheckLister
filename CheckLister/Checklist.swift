//
//  Checklist.swift
//  CheckLister
//
//  Created by Vitaly Gashock on 6/29/16.
//  Copyright © 2016 Vitaly Gashock. All rights reserved.
//

import UIKit

class Checklist: NSObject {
    var name = ""
    
    init(name: String) {
        self.name = name
        super.init()
    }
}
