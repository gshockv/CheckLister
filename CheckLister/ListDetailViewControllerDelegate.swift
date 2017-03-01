//
//  ListDetailViewControllerDelegate.swift
//  CheckLister
//
//  Created by Vitaly Gashock on 6/29/16.
//  Copyright © 2016 Vitaly Gashock. All rights reserved.
//

protocol ListDetailViewControllerDelegate: class {
    
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingChecklist checklist: Checklist)
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingChecklist checklist: Checklist)
    
}

