//
//  CategoryViewController.swift
//  Todoey
//
//  Created by John Merwin on 5/26/18.
//  Copyright © 2018 John Merwin. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework // For using colors, gradients, etc.

class CategoryViewController: SwipeTableViewController {

    let realm = try! Realm()
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Tableview data source methods
    
    //MARK: - Tableview delegate methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
        
        // Retrieve the color strings stored in the backgroundColor property
        // to paint the cells
        let backgroundColor = categories?[indexPath.row].cellBackgroundColor
        if backgroundColor  == nil {
            cell.backgroundColor = UIColor.randomFlat
        } else {
            cell.backgroundColor = UIColor(hexString: backgroundColor!)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        //tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    //MARK: - Tableview data manipulation methods
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            // Include code to respond to the "Add Item" click event
            //print(textField.text!)
            
            let newCategory =  Category()
            newCategory.name = textField.text!
            newCategory.cellBackgroundColor = UIColor.randomFlat.hexValue()
            
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
        alertTextField.placeholder = "Create New Category"
        textField = alertTextField
        //print(textField.text)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    //MARK: - Delete data from swipe
    
    override func updateModel(at indexPath: IndexPath) {
        
        // handle action by updating model with deletion
        //print("Item Deleted")
        
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting \(error)")
            }
        }
    }
}

