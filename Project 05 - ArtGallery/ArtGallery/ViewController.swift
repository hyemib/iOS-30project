
import UIKit

class ViewController: UIViewController {
    
    let artists = ArtistModel.artistFromBundle()
    
    @IBOutlet weak var artistTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        artistTableView.delegate = self
        artistTableView.dataSource = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            if let cell = sender as? UITableViewCell,
               let indexPath = artistTableView.indexPath(for: cell),
               let VC = segue.destination as? PaintingViewController {
                VC.selectedArtist = artists[indexPath.row]
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath) as! ArtistTableViewCell
        let artist = artists[indexPath.row]
        
        cell.artistImage.image = artist.image
        cell.artistTitle.text = artist.title
        cell.artistLabel.text = artist.info
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender: nil)
    }
    
    
}
