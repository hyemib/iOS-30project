
import UIKit

class ViewController: UIViewController {
    
    var artistDataModel = [ArtistDataModel]()
    
    @IBOutlet weak var artistTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        artistTableView.delegate = self
        artistTableView.dataSource = self
        
        artistDataModel = [
            ArtistDataModel(artistImage: "gogh", artistTitle: "Vincent van Gogh", artistInformation: "Vincent Willem van Gogh 30 March 1853 – 29 July 1890) was a Dutch Post-Impressionist painter who posthumously became one of the most famous and influential figures in Western art history."),
            ArtistDataModel(artistImage: "gauguin", artistTitle: "Paul Gauguin", artistInformation: "Eugène Henri Paul Gauguin (7 June 1848 – 8 May 1903) was a French Post-Impressionist artist. Unappreciated until after his death, Gauguin is now recognized for his experimental use of color and Synthetist style that were distinct from Impressionism."),
            ArtistDataModel(artistImage: "monet", artistTitle: "Claude Monet", artistInformation: "Oscar-Claude Monet (14 November 1840 – 5 December 1926) was a French painter and founder of impressionist painting who is seen as a key precursor to modernism, especially in his attempts to paint nature as he perceived it."),
            ArtistDataModel(artistImage: "cezanne", artistTitle: "Paul Cézanne", artistInformation: "Paul Cézanne (19 January 1839 – 22 October 1906) was a French artist and Post-Impressionist painter whose work laid the foundations of the transition from the 19th-century conception of artistic endeavour to a new and radically different world of art in the 20th century."),
            ArtistDataModel(artistImage: "rembrandt", artistTitle: "Rembrandt Harmenszoon van Rijn", artistInformation: "Rembrandt Harmenszoon van Rijn (15 July 1606 – 4 October 1669), usually simply known as Rembrandt, was a Dutch Golden Age painter, printmaker and draughtsman. An innovative and prolific master in three media, he is generally considered one of the greatest visual artists in the history of art and the most important in Dutch art history.")
        ]
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistDataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath) as! ArtistTableViewCell
        cell.artistImage.image = UIImage(named: (artistDataModel[indexPath.row].artistImage))
        cell.artistTitle.text = artistDataModel[indexPath.row].artistTitle
        cell.artistLabel.text = artistDataModel[indexPath.row].artistInformation
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        artistTableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
