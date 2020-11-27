//
//  ViewController.swift
//  ShoppingList
//
//  Created by Daniel Negreiros on 25/11/20.
//

import UIKit

class ShoppingListViewController: UITableViewController {

    let keyList = "ShoopinpArray"
    var itemArray = [ShoppingItemModel]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //"Frios", "Bebidas", "Carnes", "Matinal", "Feira", "Temperos"
        let newItem = ShoppingItemModel()
        newItem.title = "Frios"
        itemArray.append(newItem)
        
        let newItem2 = ShoppingItemModel()
        newItem2.title = "Bebidas"
        itemArray.append(newItem2)
        
        let newItem3 = ShoppingItemModel()
        newItem3.title = "Carnes"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: keyList) as? [ShoppingItemModel]{
            itemArray = items
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        
        cell.accessoryType = itemArray[indexPath.row].checked == true ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].checked = !itemArray[indexPath.row].checked
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add new Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
       
        let alert = UIAlertController(title: "Adicionar novo item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Adicionar", style: .default) { (action) in
            if let textDesc = textField.text {
                let addItem = ShoppingItemModel()
                addItem.title = textDesc
                self.itemArray.append(addItem)
                self.defaults.set(self.itemArray, forKey: self.keyList)
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Criar novo item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

