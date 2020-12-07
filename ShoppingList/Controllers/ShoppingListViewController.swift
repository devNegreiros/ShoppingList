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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
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
        
        loadItems()
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
        saveItems()
        
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
                self.saveItems()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Criar novo item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Model Manipulation Methods
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch{
            print("Error enconding item array, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
                
                itemArray = try decoder.decode([ShoppingItemModel].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }
}

