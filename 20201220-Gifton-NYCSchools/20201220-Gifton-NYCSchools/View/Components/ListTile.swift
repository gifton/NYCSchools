
import UIKit



class ListTile: UIView {
    
    init(title: String, subtitle: String?, iconType: ContentIcon.IconType) {
        
        super.init(frame: .zero)
        
        let icon = ContentIcon(type: iconType, size: .max)
        icon.left = left.addPadding()
        
        var content: UIView!
        
        if let subtitle = subtitle {
            
            let sLbl = createLabel(title: false, payload: subtitle)
            let tLbl = createLabel(title: false, payload: title)
            
            let stack = UIStackView(
                arrangedSubviews: [createLabel(title: true, payload: title), createLabel(title: false, payload: subtitle)],
                axis: .vertical,
                spacing: 2.5,
                alignment: .leading,
                distribution: .fillProportionally
            )
            
            stack.width = max(tLbl.width, sLbl.width)
            stack.height = tLbl.height + sLbl.height + 2.5
            content = stack
            
        } else {
            
            content = createLabel(title: true, payload: title)
            
            
        }
        
        height = max(content.height, icon.height)
        width = icon.width + content.width.addPadding(.medium).addPadding()
        print(content.frame)
        icon.centerY = centerY
        content.left = icon.right.addPadding(.medium)
        content.top = 5
        
        // label stack
        
        addSubview(icon)
        addSubview(content)
        print(content.frame, Device.width)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createLabel(title: Bool, payload: String) -> UILabel {
        
        let lbl = UILabel()
        lbl.text = payload
        lbl.width = Device.width - 75
        lbl.numberOfLines = 3
        lbl.font = UIFont.preferredFont(forTextStyle: .headline)
        lbl.adjustsFontForContentSizeCategory = true
        lbl.textColor = (title) ? UIColor.white : Colors.primaryBlue
        lbl.sizeToFit()
        
        
        return lbl
    }
}
