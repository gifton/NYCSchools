
import UIKit

extension UILabel {
    
    static func createLabel(title: Bool, payload: String, paddingFromDeviceWidth padding: CGFloat) -> UILabel {
        
        let lbl = UILabel()
        lbl.text = payload
        lbl.width = Device.width - padding
        lbl.numberOfLines = 3
        lbl.font = UIFont.preferredFont(forTextStyle: .headline)
        lbl.adjustsFontForContentSizeCategory = true
        lbl.textColor = (title) ? UIColor.white : Colors.primaryBlue
        lbl.sizeToFit()
        
        return lbl
        
    }
}

