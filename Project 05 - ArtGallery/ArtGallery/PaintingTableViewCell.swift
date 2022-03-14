
import UIKit

class PaintingTableViewCell: UITableViewCell {

    @IBOutlet weak var paintingImage: UIImageView!
    @IBOutlet weak var paintingTitle: UILabel!
    @IBOutlet weak var moreInfoBtn: UILabel!
    @IBOutlet weak var paintingLabel: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
