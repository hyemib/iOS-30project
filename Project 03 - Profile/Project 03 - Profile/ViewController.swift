
import UIKit

class ViewController: UIViewController {

    var profileModel = [[ProfileModel]]()
    @IBOutlet weak var profileTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationDesign()
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.backgroundColor = UIColor(white: 245/255, alpha: 1)
        profileTableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
        profileTableView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        
        makeData()
    }
    
    func navigationDesign() {
        self.title = "Profile"
        self.navigationController?.navigationBar.backgroundColor = .systemOrange
        self.navigationController?.navigationBar.isTranslucent = true
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
       
        let window = UIApplication.shared.windows.filter{$0.isKeyWindow}.first
        if let hasStatusBar = sceneDelegate?.statusBarView {
            window?.addSubview(hasStatusBar)
        }
    }
    
    func makeData() {
        profileModel.append(
        [ProfileModel(leftImageName: "cookie.jpeg", menuTitle: "Ena", subTitle: "View your profile", rightImageName: "chevron.right")]
        )
        
        profileModel.append(
            [ProfileModel(leftImageName: "person.2.fill", menuTitle: "Friends", subTitle: nil, rightImageName: "chevron.right"),
             ProfileModel(leftImageName: "calendar", menuTitle: "Events", subTitle: nil, rightImageName: "chevron.right"),
             ProfileModel(leftImageName: "person.3.fill", menuTitle: "Groups", subTitle: nil, rightImageName: "chevron.right"),
             ProfileModel(leftImageName: "house.fill", menuTitle: "Town Hall", subTitle: nil, rightImageName: "chevron.right"),
             ProfileModel(leftImageName: "gamecontroller.fill", menuTitle: "Instant Games", subTitle: nil, rightImageName: "chevron.right"),
             ProfileModel(leftImageName: nil, menuTitle: "See More...", subTitle: nil, rightImageName: nil)]
        )
        
        profileModel.append(
        [ProfileModel(leftImageName: nil, menuTitle: "Add Favorites...", subTitle: nil, rightImageName: nil)])
        
        profileModel.append(
        [ProfileModel(leftImageName: "gearshape.fill", menuTitle: "Settings", subTitle: nil, rightImageName: "chevron.right"),
        ProfileModel(leftImageName: "lock.fill", menuTitle: "Privacy Shortcuts", subTitle: nil, rightImageName: "chevron.right"),
         ProfileModel(leftImageName: "questionmark", menuTitle: "Help and Support", subTitle: nil, rightImageName: "chevron.right")]
        )
        
        profileModel.append(
        [ProfileModel(leftImageName: nil, menuTitle: "Log Out", subTitle: nil, rightImageName: nil)]
        )
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return "FAVORITES"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileModel[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return profileModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            cell.topTitle.text = profileModel[indexPath.section][indexPath.row].menuTitle
            cell.profileImageView.image = UIImage(named: profileModel[indexPath.section][indexPath.row].leftImageName ?? "")
            cell.bottomTitle.text = profileModel[indexPath.section][indexPath.row].subTitle
            cell.rightImageView.image = UIImage(systemName: profileModel[indexPath.section][indexPath.row].rightImageName ?? "")
            cell.rightImageView.tintColor = .systemGray3
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.leftImageView.image = UIImage(systemName: profileModel[indexPath.section][indexPath.row].leftImageName ?? "")
        cell.leftImageView.tintColor = .black
        cell.middleTitle.text = profileModel[indexPath.section][indexPath.row].menuTitle
        cell.rightImageView.image = UIImage(systemName: profileModel[indexPath.section][indexPath.row].rightImageName ?? "")
        cell.rightImageView.tintColor = .systemGray3
        if (indexPath.section == 1 && indexPath.row == 5) || indexPath.section == 2 {
            cell.middleTitle.textColor = UIColor(hex: 0x228aae)
        }
        if indexPath.section == 4 {
            cell.middleTitle.textAlignment = .center
            cell.middleTitle.textColor = .systemRed
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 36
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

public extension UIColor {
  convenience init(r: Int, g: Int, b: Int, a: CGFloat) {
    self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: a)
  }
  
  convenience init(hex: Int) {
    self.init(r: (hex & 0xff0000) >> 16, g: (hex & 0xff00) >> 8, b: (hex & 0xff), a: 1)
  }
}
