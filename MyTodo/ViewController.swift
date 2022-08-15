//
//  ViewController.swift
//  MyTodo
//
//  Created by Sushil Dhital on 03/08/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    private let table: UITableView = {
        
        let table = UITableView()
        
//        table.translatesAutoresizingMaskIntoConstraints = false
        
        table.backgroundColor = .yellow
        
        table.separatorColor = .red
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    
    }()
    
    var todoItems = [String]()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.todoItems = UserDefaults.standard.stringArray(forKey: "todoItems") ?? []
        
        title = "To Do List"
        
        view.addSubview(table)
    
        table.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
    }
        
        
    @objc private func didTapAdd(){
            
        let alert = UIAlertController(title: "New Item", message: "Enter a new todo list item", preferredStyle: .alert)
        
        alert.addTextField { field in
            
            field.placeholder = "Enter item..."
            
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self]
            (_) in
            
            if let field = alert.textFields?.first {
                
                if let text = field.text, !text.isEmpty {
                    
                    //Enter new to do list item
                    
                    DispatchQueue.main.async {
                        
                        var currentItems = UserDefaults.standard.stringArray(forKey: "todoItems") ?? []
                        
                        currentItems.append(text)
                        
                        UserDefaults.standard.setValue(currentItems, forKey: "todoItems")
                        
                        self?.todoItems.append(text)
                        
                        self?.table.reloadData()
                    }
                    
                }
                
            }
            
        }))

        present(alert, animated: true)
            
    }
        

    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        table.frame = view.bounds
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoItems.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = todoItems[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete  {
            
            self.todoItems.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    
    }
    
}
