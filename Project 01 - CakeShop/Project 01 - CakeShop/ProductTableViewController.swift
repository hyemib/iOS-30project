
import UIKit

class ProductTableViewController: UITableViewController {

    private var products: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        products = [
            Product(product: "Strawberry Chocolate Fresh Cream Cake", productImageName: "strawberryChocolate"),
            Product(product: "Mascarpone Tiramisu", productImageName: "tiramisu"),
            Product(product: "Red Velvet Cake", productImageName: "redVelvet"),
            Product(product: "Newyork Cheese Cake", productImageName: "cheese"),
            Product(product: "Strawberry Fresh Cream Cake", productImageName: "strawberryCream"),
            Product(product: "Carrot Cake", productImageName: "carrot"),
            Product(product: "Sweet Potato Milk Fresh Cream Cake", productImageName: "sweetPotato")
        ]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productDetail" {
            if let cell = sender as? UITableViewCell,
               let indexPath = tableView.indexPath(for: cell),
               let productVC = segue.destination as? ProductDetailViewController {
                productVC.product = products?[indexPath.row]
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell
        cell.productName?.text = products?[indexPath.row].product
        cell.productImage.image = UIImage(named: (products?[indexPath.row].productImageName)!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
