
import UIKit


// MARK: Controller
//  - UIViewController wrapper to handle coordinators / model data
class Controller: UIViewController {
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
