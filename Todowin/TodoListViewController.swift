//
//  ViewController.swift
//  Todowin
//
//  Created by Derick Angelo David on 12/31/18.
//  Copyright © 2018 DerickX. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{

    
    var itemArray = ["Say I'm sorry","Say you're right","Say I should've never lied to you"]
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let items = userDefaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }

    
    // MARK - TableView Datasource methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell",for:indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]

    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // MARK - TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(itemArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    // MARK - Add new items
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add your new item", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add Item", style: .default){(action)
            in
            // What happen when the alert action gets clicked
           print("Success")
            if let newItem = textField.text {
                self.itemArray.append(newItem)
                self.userDefaults.setValue(self.itemArray, forKey: "TodoListArray")
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (text) in
            text.placeholder = "Write your new item here"
            textField = text
        }

        alert.addAction(alertAction)
        present(alert,animated: true,completion: nil)
        
    }
    
}

