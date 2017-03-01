//
//  ItemDetailViewControllerDelegate.swift
//  CheckLister
//
//  Created by Vitaly Gashock on 6/22/16.
//  Copyright © 2016 Vitaly Gashock. All rights reserved.
//

protocol ItemDetailViewControllerDelegate: class {
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem)
    
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    
}
