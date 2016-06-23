//
//  AddItemViewControllerDelegate.swift
//  CheckLister
//
//  Created by Vitaly Gashock on 6/22/16.
//  Copyright © 2016 Vitaly Gashock. All rights reserved.
//

protocol AddItemViewControllerDelegate: class {
    
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
    
    func addItemViewController(controller: AddItemViewController, didFinishEditingItem item: ChecklistItem)
    
    func addItemViewControllerDelegateDidCancel(controller: AddItemViewController)
    
}
