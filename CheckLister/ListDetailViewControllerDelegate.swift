//
//  ListDetailViewControllerDelegate.swift
//  CheckLister
//
//  Created by Vitaly Gashock on 6/29/16.
//  Copyright © 2016 Vitaly Gashock. All rights reserved.
//

protocol ListDetailViewControllerDelegate: class {
    
    func listDetailViewControllerDidCancel(controller: ListDetailViewController)
    
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingChecklist checklist: Checklist)
    
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingChecklist checklist: Checklist)
    
}

