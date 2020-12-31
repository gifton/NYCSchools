
import UIKit

// Styles handles all static content delivered
//   - sizes
//   - colors
//   - fonts
//   - padding
//   - non-device relatable sizin (see Devices class)

// MARK: Styles
final class Styles {
    
    // padding
    enum Padding: CGFloat {
        case xSmall = 2.0
        case small  = 5.0
        case medium = 10.0
        case large  = 15.0
        case xLarge = 20.0
        case xXLarge = 35.0
    }
    
    // font size
    enum FontSize: CGFloat {
        case xXSmall = 8.0
        case xSmall  = 10.0
        case small   = 12.0
        case medium  = 14.0
        case large   = 16.0
        case xLarge  = 18.0
        case xXLarge = 20.0
        case xxXLarge = 30.0
        case max     = 40.0
        case emoji   = 60.0
    }

    // font
    // font is named "poppins", backup being system default
    struct Font {
        static func title(ofSize size: FontSize = FontSize.xXLarge) -> UIFont {
//            if let font = UIFont(name: "SFPro", size: size.rawValue) { return font }
//
//
//            return UIFont.systemFont(ofSize: size.rawValue, weight: .bold)
            return .systemFont(ofSize: size.rawValue, weight: .bold)
        }
        static func mediumTitle(ofSize size: FontSize = FontSize.xLarge) -> UIFont {
            if let font = UIFont(name: "Poppins-SemiBold", size: size.rawValue) { return font }
            return UIFont.systemFont(ofSize: size.rawValue, weight: .medium)
        }
        static func body(ofSize size: FontSize = FontSize.medium) -> UIFont {
            if let font = UIFont(name: "Poppins-Regular", size: size.rawValue) { return font }
            return UIFont.systemFont(ofSize: size.rawValue, weight: .regular)
        }
        static func lightBody(ofSize size: FontSize = FontSize.small) -> UIFont {
            if let font = UIFont(name: "Poppins-Light", size: size.rawValue) { return font }
            return UIFont.systemFont(ofSize: size.rawValue, weight: .light)
        }
    }
    
    
}
