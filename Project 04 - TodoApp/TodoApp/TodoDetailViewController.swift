
import UIKit
import CoreData

protocol TodoDetailViewControllerDelegate: AnyObject {
    func didFinishSaveData()
}

class TodoDetailViewController: UIViewController {

    weak var delegate: TodoDetailViewControllerDelegate?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var lowButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var highButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    var priority: PriorityLevel?
    var date: Date?
    var selectedTodoList: TodoList?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let hasData = selectedTodoList {
            titleTextField.text = hasData.title
            priority = PriorityLevel(rawValue: hasData.priorityLevel)
            makePriorityButtonDesign()
            
            deleteButton.isHidden = false
            saveButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
            saveButton.setTitle("Save", for: .normal)
        }
    }
   
    override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
        lowButton.layer.cornerRadius = lowButton.bounds.height / 2
        normalButton.layer.cornerRadius = lowButton.bounds.height / 2
        highButton.layer.cornerRadius = lowButton.bounds.height / 2
    }
    
    @IBAction func setPriority(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            priority = .level1
        case 2:
            priority = .level2
        case 3:
            priority = .level3
        default:
            break
        }
        makePriorityButtonDesign()
    }
    
    func makePriorityButtonDesign() {
        lowButton.backgroundColor = .clear
        normalButton.backgroundColor = .clear
        highButton.backgroundColor = .clear
        
        switch self.priority {
        case .level1:
            lowButton.backgroundColor = priority?.color
        case .level2:
            normalButton.backgroundColor = priority?.color
        case .level3:
            highButton.backgroundColor = priority?.color
        default:
            break
        }
    }
    
    @IBAction func setDatePicker(_ sender: UIDatePicker) {
        date = sender.date
    }
    
    
    @IBAction func saveTodo(_ sender: UIButton) {
        if selectedTodoList != nil {
            updateTodo()
        } else {
            saveTodo()
        }
        delegate?.didFinishSaveData()
        self.dismiss(animated: true)
    }
    
    func saveTodo() {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "TodoList", in: context) else { return }
        guard let object = NSManagedObject(entity: entityDescription, insertInto: context) as? TodoList else { return }
        
        object.uuid = UUID()
        object.title = titleTextField.text
        object.date = date
        object.priorityLevel = priority?.rawValue ?? PriorityLevel.level1.rawValue
    }
    
    func updateTodo() {
        guard let hasData = selectedTodoList else {
            return
        }
        
        guard let hasUUID = hasData.uuid else {
            return
        }
        
        let fetchRequesst: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        
        fetchRequesst.predicate = NSPredicate(format: "uuid = %@", hasUUID as CVarArg)
        
        do {
            let loadData = try context.fetch(fetchRequesst)
            loadData.first?.title = titleTextField.text
            loadData.first?.priorityLevel = self.priority?.rawValue ?? PriorityLevel.level1.rawValue
            loadData.first?.date = date
            
            let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
            appDelegate.saveContext()
            
        } catch {
            print(error)
        }
        
    }
    
    @IBAction func deleteTodo(_ sender: UIButton) {
        guard let hasData = selectedTodoList else {
            return
        }
        
        guard let hasUUID = hasData.uuid else {
            return
        }
        
        let fetchRequesst: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        
        fetchRequesst.predicate = NSPredicate(format: "uuid = %@", hasUUID as CVarArg)
        
        do {
            let loadData = try context.fetch(fetchRequesst)
            if let loadFirstData = loadData.first {
                context.delete(loadFirstData)
                let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
                appDelegate.saveContext()
            }
        } catch {
            print(error)
        }
        
        delegate?.didFinishSaveData()
        self.dismiss(animated: true)
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
