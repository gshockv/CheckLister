//
//  IconPickerViewControllerDelegate.swift
//  CheckLister
//
//  Created by Vitaly Gashock on 6/30/16.
//  Copyright © 2016 Vitaly Gashock. All rights reserved.
//

import Foundation

protocol IconPickerViewControllerDelegate: class {
    func iconPicker(picker: IconPickerViewController, didPickIcon iconName: String)
}
