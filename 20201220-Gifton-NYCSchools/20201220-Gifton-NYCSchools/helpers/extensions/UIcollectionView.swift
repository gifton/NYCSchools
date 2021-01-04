
import UIKit



public extension UICollectionView {
    
    // register cell with optional bundle
    // - Parameter name: UICollectionViewCell type.
    func registerCell<T: UICollectionViewCell>(_ name: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: name))
    }
    
    // - Returns: UICollectionViewCell object with associated class name.
    func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
       guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
           fatalError("Couldn't find UICollectionViewCell for \(String(describing: name))")
       }
       return cell
    }

    // register header
    func registerReusableView<T: UICollectionReusableView>(_ name: T.Type, kind: String) {
        register(name, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: name))
    }
    
    // dequeue header
    func dequeueReusableHeader<T: UICollectionReusableView>(cellWithClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewHeader for \(String(describing: name))")
        }
        return cell
    }
    
    // dequeue footer
    func dequeueReusableFooter<T: UICollectionReusableView>(cellWithClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewFooter for \(String(describing: name))")
        }
        return cell
    }
}


