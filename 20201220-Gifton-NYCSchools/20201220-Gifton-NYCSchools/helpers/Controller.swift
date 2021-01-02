
import UIKit


// MARK: Controller
//  - UIViewController wrapper to handle coordinators / model data
class Controller<T: Viewmodel>: UIViewController {
 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open var viewmodel: T
    
    init(viewmodel: T) {
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)
        
    }
    
}
