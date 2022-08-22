
import UIKit

struct todoItem {
    
    var title : String
    
    var description : String
    
//    var imgTitle : UIImage?
//
//    var imgDescription : UIImage?
    
}

class ViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
     
    @IBOutlet weak var tableView: UITableView!
    
    var todoListArray = [todoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
//        todoListArray.append(todoItem(title: "Go shopping", description: "Buy tshirt and shorts"))

        title = "To Do List"


        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))

        
        self.tableView.register(UINib( nibName: "todoCell", bundle: nil ), forCellReuseIdentifier: "todoCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    
        
        
    }
    
        @objc private func didTapAdd(){
    
            let alert = UIAlertController(title: "New Item", message: "Enter a new todo list item",   preferredStyle: .alert)
            
            alert.addTextField { field in
    
                field.placeholder = "Enter item..."
    
            }
            
            alert.addTextField()
            
            alert.textFields![0].placeholder = "Enter title"
            
            alert.textFields![1].placeholder = "Enter description"

            
    
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self]
                (_) in
    
                if let field1 = alert.textFields?.first, let field2 = alert.textFields?[1] {
    
                    if let text = field1.text, !text.isEmpty, let desc = field2.text {
    
                        //Enter new to do list item
                        DispatchQueue.main.async {
    
                            self?.todoListArray.append(todoItem(title: text, description: desc))
    
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Collection", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CollectionVC")
        self.present(controller, animated: true, completion: nil)
        
    }
 
}
