
import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var productDetailImage: UIImageView!
    @IBOutlet weak var productDetailLabel: UILabel!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productDetailLabel.text = product?.product
        
        if let imageName = product?.productImageName {
            productDetailImage.image = UIImage(named: imageName)
        }
    }
}
