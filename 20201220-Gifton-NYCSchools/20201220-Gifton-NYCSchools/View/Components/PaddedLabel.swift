
import UIKit


class PaddedLabel: UILabel {
    init(content: String, size: CGSize, color: UIColor = Colors.darkBlue, textColor: UIColor = Colors.primaryBlue) {
        super.init(frame: .init(origin: .zero, size: size))
        self.text = content
        
        font = UIFont.preferredFont(forTextStyle: .caption1)
        textAlignment = .center
        backgroundColor = color.withAlphaComponent(0.5)
        self.textColor = textColor
        layer.cornerRadius = 4
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
