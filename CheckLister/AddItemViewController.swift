//
//  AddItemViewController.swift
//  CheckLister
//
//  Created by Vitaly Gashock on 6/22/16.
//  Copyright © 2016 Vitaly Gashock. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: AddItemViewControllerDelegate?
    var itemToEdit: ChecklistItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.enabled = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    @IBAction func done() {
        if let item = itemToEdit {
            item.text = textField.text!
            delegate?.addItemViewController(self, didFinishEditingItem: item)
        } else {
            let item = ChecklistItem()
            item.text = textField.text!
            item.checked = false
            
            delegate?.addItemViewController(self, didFinishAddingItem: item)
        }
    }
    
    @IBAction func cancel() {
        delegate?.addItemViewControllerDelegateDidCancel(self)
    }
    
    // ==================================================================================================================
    // table view delegate methods
    // ==================================================================================================================
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    // ==================================================================================================================
    // text field delegate methods
    // ==================================================================================================================
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        doneBarButton.enabled = newText.length > 0
        return true
    }
}
