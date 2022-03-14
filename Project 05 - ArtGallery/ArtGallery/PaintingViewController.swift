
import UIKit

class PaintingViewController: UIViewController {
    
    @IBOutlet weak var paintingTableView: UITableView!
    
    var selectedArtist: ArtistModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paintingTableView.delegate = self
        paintingTableView.dataSource = self
    }
}


extension PaintingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaintingCell", for: indexPath) as! PaintingTableViewCell
        return cell
    }
}

