

import UIKit

struct Colors {
        
    // background
    static let darkGray      = UIColor(hex: "5C5C5C")
    static let lightGray     = UIColor(hex: "ECECEC")
    static let overlayWhite  = UIColor(hex: "ffffff").withAlphaComponent(0.24)
    static let offWhite      = UIColor(hex: "F4F4F5")
    static let cream         = Colors.offWhite /// UIColor(hex: "F6F5F0")
    static let yellow        = UIColor(hex: "FFC260")
    static let primaryRed    = UIColor(hex: "EF5350")
//        static let primaryBlue   = UIColor(hex: "475AF0")
    
    static let secondaryBlue = UIColor(hex: "84A3FB")
    static let accentBlue    = UIColor(hex: "A1BAFF")
    static let primaryGreen  = UIColor(named: "primary-green")!
    static let white         = UIColor(named: "main-white")!
    static let black         = UIColor(named: "main-black")!
    
    // misc
    static let secondaryGray  = UIColor(hex: "3D3B43")
    static let secondaryGreen = UIColor(hex: "318B82")
    static let bglightBlue    = UIColor(hex: "D9E0F5")
    static let bglightClay    = UIColor(hex: "EBF0FF")
    static let darkBlue       = UIColor(hex: "132749")
    static let purple         = UIColor(hex: "5E62B5")
    
    static let primaryBlue    = UIColor(hex: "6271fc")
    static let softBG = UIColor(named: "background-soft")!
    static let hardBG = UIColor(named: "background-hard")!
    static let primaryText = UIColor(named: "primary-text")!
    static let secondaryText = UIColor(named: "secondary-text")!
    
    
    struct UserSelectable {
        
        static let blue = UIColor(hex: "558BB5")
        static let yellow = UIColor(hex: "FF8A5B")
        static let black = Colors.black
        static let offWhite = Colors.offWhite
        static let orange = UIColor(hex: "FF8A5B")
        static let pink = UIColor(hex: "EA526F")
        static let green = UIColor(hex: "96E6B3")
        static let purple = UIColor(hex: "2C2A4A")
        
        func textColorForColor(_ color: UserSelectable) {
            
        }
    }
}

extension Array where Element == UIColor {
    var cgColors: [CGColor] {
        return map {
            return $0.cgColor
        }
    }
}

// MARK: UIColor helper methods (converting hex)
extension UIColor {
    
    
    
// UIColor does not base its system off of hex, rather RGB(a)
// allows input as hex values instead of standard UIcolor init
    convenience init(hex: String) {
        // trim chars
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        // remove hashtag (lol)
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        // return gray if all 3 colorcodes are not present
        if ((cString.count) != 6) {
            self.init(red: UIColor.gray.rgba.red, green: UIColor.gray.rgba.green, blue: UIColor.gray.rgba.blue, alpha: 1.0)
        }
        
        // find rgb by getting hex code of string from scanner
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        let color = UIColor (
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
        self.init(red: color.rgba.red, green: color.rgba.green, blue: color.rgba.blue, alpha: 1.0)
    }
    
    // retrieve RBG-A values from color
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
}

public extension UIColor {
    
    // set color to random set of hex values
    static var random: UIColor {
        let max = CGFloat(UInt32.max)
        let red = CGFloat(arc4random()) / max
        let green = CGFloat(arc4random()) / max
        let blue = CGFloat(arc4random()) / max
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    static var sparkColorSet: [UIColor] = {
        return [
            UIColor(red:0.89, green:0.58, blue:0.70, alpha:1.00),
            UIColor(red:0.96, green:0.87, blue:0.62, alpha:1.00),
            UIColor(red:0.67, green:0.82, blue:0.94, alpha:1.00),
            UIColor(red:0.54, green:0.56, blue:0.94, alpha:1.00),
        ]
    }()
    
    var isDarkColor: Bool {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  lum < 0.50
    }
}
