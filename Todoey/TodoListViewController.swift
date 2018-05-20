//
//  ViewController.swift
//  Todoey
//
//  Created by John Merwin on 5/20/18.
//  Copyright © 2018 John Merwin. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Cell 1", "Cell 2", "Cell 3"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
    }

    //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
           tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        // Deselect the row after it has been selected
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

