
import UIKit


final class SchoolsController: Controller<SchoolsViewmodel> {
    
    override init(viewmodel: SchoolsViewmodel) {
        super.init(viewmodel: viewmodel)
        
        view.backgroundColor = UIColor.white
        
        viewmodel.start { err in
            if err != nil {
                print(err as Any)
            }

            assert(self.viewmodel.schools != nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    deinit {
        
    }
    
    private var collectionView: UICollectionView!
    
    
    enum Section {
      case main
    }
    
    private var schools: [SchoolCellViewModel] = []
    
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, SchoolCellViewModel>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, SchoolCellViewModel>
    
    private var contentDataSource: UICollectionViewDiffableDataSource<Section, SchoolCellViewModel>! = nil
    
}



