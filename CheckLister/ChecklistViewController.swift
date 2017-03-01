//
//  ViewController.swift
//  CheckLister
//
//  Created by Vitaly Gashock on 6/21/16.
//  Copyright © 2016 Vitaly Gashock. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {

    var checklist: Checklist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = checklist.name
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var navController: UINavigationController?
        var destController: ItemDetailViewController?
        
        if segue.identifier == "AddItemSegue" || segue.identifier == "EditItemSegue" {
            navController = segue.destination as? UINavigationController
            destController = navController?.topViewController as? ItemDetailViewController
            destController?.delegate = self
        }
        if (segue.identifier == "EditItemSegue") {
            // put ChecklistItem to destination controller
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                destController?.itemToEdit = checklist.items[indexPath.row]
            }
        }
    }
    
    
    // MARK: - Item details view controller delegate methods
    
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
        let newRowIndex = checklist.items.count
        checklist.items.append(item)
        let indexPaths = [IndexPath(row: newRowIndex, section: 0)]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
        if let index = checklist.items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureTextForCell(cell, withChecklistItem: item)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklist.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = checklist.items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        
        configureTextForCell(cell, withChecklistItem: item)
        configureCheckmarkForCell(cell, withChecklistItem: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = checklist.items[indexPath.row]
            item.toggleChecked()
            configureCheckmarkForCell(cell, withChecklistItem: item)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        checklist.items.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    func configureTextForCell(_ cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    func configureCheckmarkForCell(_ cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        
        if item.checked {
            label.text = "✓"
        } else {
            label.text = ""
        }
        
        label.textColor = view.tintColor
    }
}
