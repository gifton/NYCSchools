
import UIKit


class SchoolsListHeader: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.darkBlue.withAlphaComponent(0.6)
    }
    
    private var count = 0
    private var location = "New York City"
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setCount(_ count: Int) {
        self.count = count
        
        setView()
    }
    
    public func searchCompletion(_ completion: @escaping (String) -> ()) {
        search = completion
    }
    
    private var search: ((String) -> ())?
    
    private let searchView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 6
        v.layer.cornerCurve = .continuous
        v.backgroundColor = Colors.darkBlue
        v.layer.masksToBounds = true
        v.frame.size = .init(Device.width.subtractPadding(.large, multiplier: 2), 80)
        return v
    }()
    
    private let countView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 6
        v.layer.cornerCurve = .continuous
        v.backgroundColor = Colors.darkBlue
        v.layer.masksToBounds = true
        v.frame.size = .init((Device.width / 2).subtractPadding(.large, multiplier: 2), 40)
        return v
    }()
    
    private let locationView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 6
        v.layer.cornerCurve = .continuous
        v.backgroundColor = Colors.darkBlue
        v.layer.masksToBounds = true
        v.frame.size = .init((Device.width / 2).subtractPadding(.large, multiplier: 2), 40)
        return v
    }()
    
}


private extension SchoolsListHeader {
    func setView() {
        
        searchView.frame.origin = .init(Styles.Padding.large.rawValue)
        addSubview(searchView)
        
        countView.frame.origin = .init(Styles.Padding.large.rawValue, searchView.frame.bottom.addPadding(.medium))
        addSubview(countView)
        
        locationView.frame.right = searchView.frame.right
        locationView.frame.top = searchView.frame.bottom.addPadding(.medium)
        addSubview(locationView)
        
        let searchbar = UISearchBar()
        searchbar.frame.size = .init(searchView.frame.width.subtractPadding(.xLarge, multiplier: 2),60)
        searchbar.frame.left = Styles.Padding.xLarge.rawValue
        searchbar.frame.center.y = searchView.frame.height / 2
        searchbar.backgroundImage = UIImage()
        searchbar.barStyle = .default
        searchbar.placeholder = "Search for a school"
        searchbar.backgroundColor = .clear
        searchbar.tintColor = .clear
        searchbar.delegate = self
        searchbar.layer.backgroundColor = UIColor.clear.cgColor
        searchView.addSubview(searchbar)
        
        let countLabel = UILabel()
        countLabel.text = "Schools"
        countLabel.sizeToFit()
        countLabel.textColor = UIColor.white
        countView.addSubview(countLabel)
        countLabel.frame.left = Styles.Padding.large.rawValue
        countLabel.center.y = countView.frame.height / 2
        
        let schoolCountLabel = UILabel()
        schoolCountLabel.text = "\(count)"
        schoolCountLabel.font = Styles.Font.mediumTitle()
        schoolCountLabel.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        schoolCountLabel.textColor = Colors.primaryBlue
        schoolCountLabel.frame.size.height = countView.frame.height
        schoolCountLabel.frame.size.width = (countView.frame.width - countLabel.frame.right).subtractPadding()
        schoolCountLabel.textAlignment = .center
        countView.addSubview(schoolCountLabel)
        schoolCountLabel.frame.left = countLabel.frame.right.addPadding()
        schoolCountLabel.frame.center.y = countView.frame.height / 2
        
        let cityLabel = UILabel()
        cityLabel.text = location
        cityLabel.sizeToFit()
        cityLabel.textColor = UIColor.white
        locationView.addSubview(cityLabel)
        cityLabel.frame.center.x = locationView.frame.width / 2
        cityLabel.center.y = locationView.frame.height / 2
        
    }
    
}

extension SchoolsListHeader: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let search = search, let predicate = searchBar.text {
            search(predicate)
        }
        
    }
}
