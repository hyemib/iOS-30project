

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var menu = [Menu]()
    private var filterMenu = [Menu]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setUpTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let menus: Menu
                if searchController.isActive {
                    menus = filterMenu[(indexPath as NSIndexPath).row]
                } else {
                    menus = menu[(indexPath as NSIndexPath).row]
                }
                let controller = segue.destination as! MenuDetailViewController
                controller.detailMenu = menus
            }
        }
    }
    
    func setupNavigationBar() {
        searchController.searchBar.scopeButtonTitles = ["Coffee", "Frappe", "Tea", "All"]
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchResultsUpdater = self
        
        navigationItem.title = "Cafe"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        menu = [Menu(category: "Coffee", name: "Espresso", imageName: "espresso"),
                Menu(category: "Coffee", name: "Americano", imageName: "americano"),
                Menu(category: "Coffee", name: "Caffe Latte", imageName: "cappuccino"),
                Menu(category: "Coffee", name: "Cappuccino", imageName: "caffe_latte"),
                Menu(category: "Coffee", name: "Caffe Mocha", imageName: "caffe_mocha"),
                Menu(category: "Coffee", name: "Vanilla Latte", imageName: "vanilla_latte"),
                Menu(category: "Coffee", name: "Caramel Macchiato", imageName: "caramel_macchiato"),
                Menu(category: "Coffee", name: "Dolce Latte", imageName: "dolce_latte"),
                Menu(category: "Frappe", name: "Java Chip Frappe", imageName: "java_chip_frappe"),
                Menu(category: "Frappe", name: "Mocha Frappe", imageName: "mocha_frappe"),
                Menu(category: "Frappe", name: "Chocolate Chip Frappe", imageName: "chocolate_chip_frappe"),
                Menu(category: "Frappe", name: "Green Tea Frappe", imageName: "green_tea_frappe"),
                Menu(category: "Frappe", name: "Vanilla Frappe", imageName: "vanilla_frappe"),
                Menu(category: "Tea", name: "Chamomile", imageName: "chamomile_tea"),
                Menu(category: "Tea", name: "Earl Gray", imageName: "earl_gray"),
                Menu(category: "Tea", name: "Milk Tea", imageName: "milk_tea"),
                Menu(category: "Tea", name: "Mint Tea", imageName: "mint_tea"),
                Menu(category: "Tea", name: "Green Tea", imageName: "green_tea")
        ]
    }
    
    func filterSearchText(_ searchText: String, scope: String = "All") {
        filterMenu = menu.filter({ menus in
            if !(menus.category == scope) && scope != "All" {
                return false
            }
            return menus.name.lowercased().contains(searchText.lowercased()) || searchText == ""
        })
        tableView.reloadData()
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        
        filterSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? filterMenu.count : menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell
        
        if searchController.isActive {
            cell.menuName!.text = filterMenu[indexPath.row].name
            cell.menuCategory!.text = filterMenu[indexPath.row].category
        } else {
            cell.menuName!.text = menu[indexPath.row].name
            cell.menuCategory!.text = menu[indexPath.row].category
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

