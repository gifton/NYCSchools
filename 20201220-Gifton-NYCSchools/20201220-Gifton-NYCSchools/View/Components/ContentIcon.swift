
import UIKit



class ContentIcon: UIView {
    init(type: IconType, size: Styles.FontSize) {
        super.init(frame: .init(origin: .zero, size: .init(size.rawValue)))
        
        let img = UIImageView(image: UIImage(
                                systemName: type.rawValue,
            withConfiguration:  UIImage.SymbolConfiguration(pointSize: size.rawValue / 1.5, weight: .bold)
        ))
        
        img.tintColor = UIColor.white
        
        img.frame.center = center
        img.contentMode = .scaleToFill
        addSubview(img)
        
        backgroundColor = Colors.offWhite.withAlphaComponent(0.7)
        layer.cornerRadius = height / 2
        layer.masksToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    enum IconType: String {
        case location = "location.circle.fill"
        case phone = "phone.circle.fill"
        case website = "safari.fill"
        case math = "funciton"
        case writing = "pencil"
        case reading = "book"
        case share = "chevron.right.circle.fill"
    }
}
