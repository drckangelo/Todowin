//
//  ViewController.swift
//  Todowin
//
//  Created by Derick Angelo David on 12/31/18.
//  Copyright © 2018 DerickX. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{

    
    var itemArray = [Item]()
    let userDefaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(dataFilePath)
        
        loadItems()
//       if let items = userDefaults.array(forKey: "TodoListArray") as? [Item] {
//           itemArray = items
//        }
        
    }

    
    // MARK - TableView Datasource methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell",for:indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title

        let item = itemArray[indexPath.row]
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // MARK - TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
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
                
                let item = Item()
                item.title = newItem
                self.itemArray.append(item)
                self.saveItems()
//              self.userDefaults.setValue(self.itemArray, forKey: "TodoListArray")
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
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
    
        } catch  {
            print("Error encoding item array \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item")
            }
            
        }
    }
}

