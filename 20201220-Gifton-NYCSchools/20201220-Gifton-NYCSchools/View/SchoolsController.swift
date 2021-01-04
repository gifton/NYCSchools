
import UIKit


final class SchoolsController: Controller<SchoolsViewmodel> {
    
    override init(viewmodel: SchoolsViewmodel) {
        super.init(viewmodel: viewmodel)
        
        title = "New York Schools"
        
        
        view.backgroundColor = UIColor.white
        
        viewmodel.start { err in
            
            if err != nil {
                print(err as Any)
            }

            assert(self.viewmodel.schools != nil)
            self.setView()
            
        }
        
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    deinit {
        
    }
    
    enum Section { case main }
    
    private var collectionView: UICollectionView!
    private var schools: [SchoolCellViewModel]? { return viewmodel.schools }
    private var contentDataSource: UICollectionViewDiffableDataSource<Section, SchoolCellViewModel>! = nil
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, SchoolCellViewModel>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, SchoolCellViewModel>
    
}

extension SchoolsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let selectedSchool = viewmodel.schools?[indexPath.row].school, let nav = navigationController else { return }
        
        let vm = SchoolDetailViewmodel(school: selectedSchool)
        nav.present(SchoolDetailController(viewmodel: vm), animated: true) {
            
        }
        
    }
}


private extension SchoolsController {
    
    func setView() {
        
        if let _ = viewmodel.schools {
            
            collectionView = UICollectionView(frame: Device.frame, collectionViewLayout: generateLayout())
            collectionView.registerReusableView(SchoolsListHeader.self, kind: UICollectionView.elementKindSectionHeader)
            collectionView.registerCell(SchoolCell.self)
            collectionView.isPrefetchingEnabled = false
            collectionView.delegate = self
            collectionView.backgroundColor = .black
            collectionView.contentInsetAdjustmentBehavior = .always
            collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            collectionView.showsVerticalScrollIndicator = false
            configureDataSource()
            collectionView.dataSource = contentDataSource
            view.addSubview(collectionView)
            
        } else {
            
        }
        
    }
    
    // collectionview layout with header
    func generateLayout() -> UICollectionViewLayout {
        
        // number of items
        let displayableItems = [NSCollectionLayoutItem](repeating: collectionCellLayoutItemAttributes, count: schools?.count ?? 0)
        
        // size (width and set height)
        let nestedGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(65.0)),
            subitems: displayableItems
        )
        
        // header size
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(165)
        )
        
        // header
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        // build layout
        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.boundarySupplementaryItems = [sectionHeader]
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    var collectionCellLayoutItemAttributes: NSCollectionLayoutItem {
        let sequenceItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/2.75)),
            supplementaryItems: []
        )
        
        sequenceItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5)
        return sequenceItem
    }
    
    func configureDataSource() {
        
        contentDataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, vm) -> UICollectionViewCell in
                let cell = collectionView.dequeueReusableCell(withClass: SchoolCell.self, for: indexPath)
                cell.set(withModel: vm)
                return cell
            }
            
        )
        
        var snapshot = Snapshot()
        guard let schools = schools else { return }
        snapshot.appendSections([.main])
        snapshot.appendItems(schools, toSection: .main)
        contentDataSource.supplementaryViewProvider = {
            (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            if kind == UICollectionView.elementKindSectionHeader {
                let head = collectionView.dequeueReusableHeader(cellWithClass: SchoolsListHeader.self, for: indexPath)
                head.setCount(self.viewmodel.schools?.count ?? 0)
                head.searchCompletion { [weak self] (pred) in
                    print(pred)
                    if let SELF = self {
//                        SELF.viewmodel.sear
                    }
                }
                return head
            }
            
            return nil
        }
        
        contentDataSource.apply(snapshot)
        
    }
}

