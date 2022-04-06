
import UIKit

class MenuDetailViewController: UIViewController {

    @IBOutlet weak var menuDetailImage: UIImageView!
    @IBOutlet weak var menuDetailName: UILabel!
    
    var detailMenu: Menu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        if let detailMenu = detailMenu {
            if let menuImage = menuDetailImage, let menuName = menuDetailName {
                menuImage.image = UIImage(named: detailMenu.imageName)
                menuName.text = detailMenu.name
                
                title = detailMenu.category
            }
        }
    }
}
