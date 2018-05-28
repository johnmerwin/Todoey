//
//  ViewController.swift
//  Todoey
//
//  Created by John Merwin on 5/20/18.
//  Copyright © 2018 John Merwin. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    var toDoItems: Results<Item>?
    // toDOItems  = array of Results that consistes of Item objects
    
    let realm = try! Realm()
   
    var selectedCategory: Category? {
        didSet{
            loadItems()
        }
    }
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath)
    }

    //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
       
        if let item = toDoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done == true ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No items added"
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
        
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Code for deleting an item from the list
        
//        if let item = toDoItems?[indexPath.row] {
//            do {
//                try realm.write {
//                    realm.delete(item)
//                }
//            } catch {
//                print("Error saving done status \(error)")
//            }
//        }
        
        // Code for updating an item
        
        if let item = toDoItems?[indexPath.row] {
            do {
                try self.realm.write {
                   item.done = !item.done
                }
            } catch {
                print("Error saving done status \(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem =  Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving todo item \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
        alertTextField.placeholder = "Create New Item"
        textField = alertTextField 
        
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
   
    func loadItems() {
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
}


//MARK: Search bar methods

// Extending the TodoListViewController to modularize delegate
// functions

extension TodoListViewController:  UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@",searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        toDoItems = toDoItems?.sorted(byKeyPath: "title", ascending: true)
        
        // No need to call loadItems() because it is already called
        // before. Here we are just filter the toDoItems
        
        tableView.reloadData()

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            // Make sure that the kbd disappears in the
            // main thread of the app.
            // Remove the focus from the search bar

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
}
