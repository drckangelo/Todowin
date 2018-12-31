//
//  ViewController.swift
//  Todowin
//
//  Created by Derick Angelo David on 12/31/18.
//  Copyright © 2018 DerickX. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{

    
    let itemArray = ["Say I'm sorry","Say you're right","Say I should've never lied to you"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    
   
}

