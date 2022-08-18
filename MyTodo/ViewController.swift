
import UIKit

struct todoItem {
    
    var title : String
    
    var description : String
    
    var imgTitle : UIImage?
    
    var imgDescription : UIImage?
    
}

class ViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
     
    @IBOutlet weak var tableView: UITableView!
    
    var todoListArray = [todoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        todoListArray.append(todoItem(title: "Go shopping", description: "Buy tshirt and shorts", imgTitle: UIImage(named: "boy"), imgDescription: UIImage(named: "girl" )))

        title = "To Do List"


        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))

        
        self.tableView.register(UINib( nibName: "todoCell", bundle: nil ), forCellReuseIdentifier: "todoCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        debugPrint(self.todoListArray)
        
        
        
    }
    
        @objc private func didTapAdd(){
    
            let alert = UIAlertController(title: "New Item", message: "Enter a new todo list item",   preferredStyle: .alert)
            
            let imageView = UIImageView(frame: CGRect(x: 220, y: 10, width: 40, height: 40))
            imageView.image = UIImage(named: "boy")

            alert.view.addSubview(imageView)
            
            alert.addTextField { field in
    
                field.placeholder = "Enter item..."
    
            }
            
            alert.addTextField()
            
            alert.textFields![0].placeholder = "Enter title"
            
            alert.textFields![1].placeholder = "Enter description"

            
    
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
    
                            self?.todoListArray.append(todoItem(title: text, description: text))
    
                            self?.tableView.reloadData()
                        }
    
                    }
    
                }
    
            }))
    
            present(alert, animated: true)
    
        }

    

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return self.todoListArray.count

        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)  as! todoCell
                
                cell.lblTitle.text  = self.todoListArray[indexPath.row].title
                
                cell.lblDescription.text = self.todoListArray[indexPath.row].description
            
            cell.imgTitle.image = self.todoListArray[indexPath.row].imgTitle
            
            cell.imgDescription.image = self.todoListArray[indexPath.row].imgDescription
            
            return cell
                
//            }
//
//            return UITableViewCell()
            
        }

            func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
                if editingStyle == .delete  {
        
                    self.todoListArray.remove(at: indexPath.row)
        
                    tableView.deleteRows(at: [indexPath], with: .automatic)
        
                }
        
            }
 
}
