
import Foundation
import UIKit

struct ArtistModel {
    var image: UIImage
    var title: String
    var info: String
    var paintingModel: [PaintingModel]
    
    init(image: UIImage, title: String, info: String, paintingModel: [PaintingModel]) {
        self.image = image
        self.title = title
        self.info = info
        self.paintingModel = paintingModel
    }
    
    static func artistFromBundle() -> [ArtistModel] {
        var artistModels = [ArtistModel]()
        
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            return artistModels
        }
        
        do {
            let data = try Data(contentsOf: url)
            guard let rootObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return artistModels
            }
    
            guard let artistObjects = rootObject["data"] as? [[String: AnyObject]] else {
                return artistModels
            }
            
            for artistObject in artistObjects {
                if let imageName = artistObject["image"] as? String,
                   let image = UIImage(named: imageName),
                   let title = artistObject["title"] as? String,
                   let info = artistObject["info"] as? String,
                   let paintingObjects = artistObject["painting"] as? [[String:String]] {
                    var painting = [PaintingModel]()
                    for paintingObject in paintingObjects {
                        if let paintingImageName = paintingObject["paintingImage"],
                           let paintingImage = UIImage(named: paintingImageName + ".jpg"),
                           let paintingTitle = paintingObject["paintingTitle"],
                           let paintingInfo = paintingObject["paintingInfo"] {
                            painting.append(PaintingModel(image: paintingImage, title: paintingTitle, info: paintingInfo))
                        }
                    }
                    let artist = ArtistModel(image: image, title: title, info: info, paintingModel: painting)
                    artistModels.append(artist)
                }
            }
            
        } catch {
            return artistModels
        }
        
        return artistModels
    }
}
