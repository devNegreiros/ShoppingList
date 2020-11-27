//
//  ViewController.swift
//  ShoppingList
//
//  Created by Daniel Negreiros on 25/11/20.
//

import UIKit

class ShoppingListViewController: UITableViewController {

    let keyList = "ShoopinpArray"
    var itemArray = ["Frios", "Bebidas", "Carnes", "Matinal", "Feira", "Temperos"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: keyList) as? [String]{
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
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.none{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add new Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
       
        let alert = UIAlertController(title: "Adicionar novo item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Adicionar", style: .default) { (action) in
            if let textDesc = textField.text {
                self.itemArray.append(textDesc)
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

