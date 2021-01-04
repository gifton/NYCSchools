
import UIKit


final class SchoolDetailController: Controller<SchoolDetailViewmodel> {
    
    private enum SchoolDetailPage {
        case overview, contact, grades
    }
    
    override init(viewmodel: SchoolDetailViewmodel) {
        super.init(viewmodel: viewmodel)
        edgesForExtendedLayout = []
        view.backgroundColor = Colors.darkBlue
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel = UILabel()
    
    private let scrollView = UIScrollView()
    private let panel = UIView(withColor: Colors.darkBlue)
    private let infoLabel = UILabel()
    private var currentPage: SchoolDetailPage = .overview
    
}



private extension SchoolDetailController {
    func setView() {
        
        view.backgroundColor = .clear
        panel.frame.size = .init(Device.width)
        panel.frame.size.height += panel.frame.size.width / 1.75
        panel.layer.cornerRadius = 30
        view.addSubview(panel)
        panel.bottom = view.bottom
        
        let dragIndicator = UIView(withColor: UIColor.white.withAlphaComponent(0.1))
        dragIndicator.frame.size = .init(60, 10)
        dragIndicator.layer.cornerRadius = 5
        dragIndicator.layer.masksToBounds = true
        dragIndicator.center.x = panel.center.x
        dragIndicator.top += CGFloat.zero.addPadding()
        panel.addSubview(dragIndicator)
        
        titleLabel.text = viewmodel.schoolName
        titleLabel.numberOfLines = 3
        titleLabel.width = panel.width.subtractPadding(.large, multiplier: 2)
        titleLabel.height = 100
        titleLabel.textColor = Colors.primaryBlue
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.left = panel.left.addPadding()
        titleLabel.top = dragIndicator.bottom.addPadding(.small)
        panel.addSubview(titleLabel)
        
        setHeader()
    }
    
    func setHeader() {
        
        infoLabel.text = "School Info"
        infoLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        infoLabel.adjustsFontForContentSizeCategory = true
        infoLabel.sizeToFit()
        infoLabel.width += 20
        infoLabel.height += 20
        infoLabel.textAlignment = .center
        infoLabel.backgroundColor = Colors.primaryBlue
        infoLabel.layer.cornerRadius = infoLabel.height / 2
        infoLabel.layer.masksToBounds = true
        infoLabel.left = titleLabel.left
        infoLabel.top = titleLabel.bottom.addPadding()
        panel.addSubview(infoLabel)
        
        setSchoolInfo()
    }
    
    func setSchoolInfo() {
        
        scrollView.frame.size = .init(Device.width, panel.height - infoLabel.bottom.addPadding())
        scrollView.top = infoLabel.bottom.addPadding(.small)
        scrollView.delegate = self
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = .init(Device.width * 3, scrollView.height)
        panel.addSubview(scrollView)
        
        scrollView.addSubview(buildSchoolContent())
        
    }
    
    func buildSchoolContent() -> UIView {
        // overview
        // location / contact
        // student count / attendance rate / final grades
        let overviewCard = UIView()
        let contactCard = UIView()
        let countCard = UIView()
        
        [overviewCard, contactCard, countCard].forEach {
            $0.layer.cornerRadius = 10
            $0.frame.size = .init(Device.width.subtractPadding(.large, multiplier: 2), scrollView.height.subtractPadding(.large, multiplier: 2))
            $0.backgroundColor = UIColor.black.withAlphaComponent(0.25)

            $0.alpha = 0.75
        }
        
        setOverView(onView: overviewCard)
        setCountCard(onView: countCard)
        setContactInfo(onView: contactCard)
        
        let stack = UIStackView(arrangedSubviews: [overviewCard, contactCard, countCard], axis: .horizontal, spacing: 10, alignment: .fill, distribution: .fillEqually)
        stack.left = Styles.Padding.small.rawValue
        stack.top = Styles.Padding.medium.rawValue
        stack.width = (Device.width.subtractPadding() * 3)
        stack.height = overviewCard.height.subtractPadding(.large, multiplier: 3)
        
        return stack
    }
    
    
    func setOverView(onView: UIView) {
        
        let titleLabel = UILabel()
        titleLabel.text = "Overview"
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        titleLabel.left = CGFloat.zero.addPadding()
        titleLabel.top = CGFloat.zero.addPadding()
        onView.addSubview(titleLabel)
        
        let overview = UILabel()
        overview.adjustsFontForContentSizeCategory = true
        overview.adjustsFontSizeToFitWidth = true
        overview.font = UIFont.preferredFont(forTextStyle: .body)
        overview.textColor = Colors.primaryBlue
        overview.text = viewmodel.overview
        overview.numberOfLines = 20
        overview.width = onView.width.subtractPadding(.large, multiplier: 2)
        overview.sizeToFit()
        overview.layer.masksToBounds = true
        overview.left = CGFloat.zero.addPadding()
        overview.top = titleLabel.bottom
        
        onView.addSubview(overview)
        
    }
    
    func setContactInfo(onView: UIView) {
        
        // content title
        let titleLabel = UILabel()
        titleLabel.text = "Contact"
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        titleLabel.left = CGFloat.zero.addPadding()
        titleLabel.top = CGFloat.zero.addPadding()
        onView.addSubview(titleLabel)
        
        // location icon
        let locationIcon = ContentIcon(type: .location, size: .max)
        locationIcon.left = onView.left.addPadding(.xLarge)
        locationIcon.top = titleLabel.bottom.addPadding(.xXLarge)
        
        // location label
        let locationLabel = UILabel()
        locationLabel.text = viewmodel.location
        locationLabel.width = onView.width - 75
        locationLabel.numberOfLines = 3
        locationLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        locationLabel.adjustsFontForContentSizeCategory = true
        locationLabel.textColor = UIColor.white
        locationLabel.sizeToFit()
        
        // open in maps label
        let mapsLabel  = UILabel()
        mapsLabel.text = "Open in maps"
        mapsLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        mapsLabel.adjustsFontForContentSizeCategory = true
        mapsLabel.textColor = Colors.primaryBlue
        mapsLabel.sizeToFit()
        
        let locationTile = ListTile(title: viewmodel.location, subtitle: "Open in maps", iconType: .location)
        locationTile.top = titleLabel.bottom.addPadding()
        onView.addSubview(locationTile)
        
        // website
        let websiteLabel = UILabel()
        websiteLabel.text = viewmodel.website?.absoluteString ?? "invalid URL"
        websiteLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        websiteLabel.adjustsFontForContentSizeCategory = true
        websiteLabel.textColor = Colors.primaryBlue
        websiteLabel.sizeToFit()
        
        // location icon
        let websiteIcon = ContentIcon(type: .website, size: .max)
        websiteIcon.left = CGFloat.zero.addPadding()
        websiteIcon.bottom = onView.bottom - 55
       
        websiteLabel.left = websiteIcon.right.addPadding()
        websiteLabel.centerY = websiteIcon.centerY
        
        onView.addSubview(websiteIcon)
        onView.addSubview(websiteLabel)
        
        let phoneView = UIView(withColor: UIColor.white.withAlphaComponent(0.15))
        phoneView.frame.size = .init(onView.width.subtractPadding(.xLarge, multiplier: 2), 45)
        phoneView.left = CGFloat.zero.addPadding()
        phoneView.top = locationTile.bottom.addPadding(.xXLarge)
        phoneView.layer.cornerRadius = 8
        phoneView.layer.masksToBounds = true
        
        let phoneImage = UIImageView(image: UIImage(systemName: ContentIcon.IconType.phone.rawValue, withConfiguration:  UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)))
        phoneImage.frame.size = .init(35)
        phoneImage.left = CGFloat.zero.addPadding()
        phoneImage.centerY = phoneView.height / 2
        phoneImage.tintColor = Colors.primaryBlue
        phoneView.addSubview(phoneImage)
        
        onView.addSubview(phoneView)
        
        let phoneNumber = UILabel.createLabel(title: false, payload: viewmodel.phone, paddingFromDeviceWidth: Device.width / 2.5)
        phoneNumber.sizeToFit()
        phoneNumber.left = phoneImage.right.addPadding()
        phoneNumber.centerY = phoneImage.centerY
        phoneView.addSubview(phoneNumber)
        
        let callButton = UILabel.createLabel(title: true, payload: "Call", paddingFromDeviceWidth: 0)
        callButton.sizeToFit()
        callButton.textColor = UIColor.green
        callButton.right = phoneView.right.subtractPadding(.xXLarge)
        callButton.centerY = phoneNumber.centerY
        phoneView.addSubview(callButton)
        
        
    }
    
    func setCountCard(onView: UIView) {
        
        if (viewmodel.testScores == nil) {
            
            print("setting viewmodel" )
            let img = UIImageView(
                image: UIImage(
                    systemName: "eye.slash",
                    withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .bold)
                )
            )
            
            img.contentMode = .scaleAspectFit
            img.frame.size = .init(50)
            img.tintColor = Colors.offWhite
            img.center.x = onView.width / 2
            img.top = CGFloat.zero.addPadding(.xLarge)
            onView.addSubview(img)
            let titleLabel = UILabel()
            titleLabel.text = "There arent any test Scores available for this school"
            titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
            titleLabel.width = onView.width.subtractPadding(.xLarge, multiplier: 2)
            titleLabel.numberOfLines = 2
            titleLabel.adjustsFontForContentSizeCategory = true
            titleLabel.textColor = UIColor.white
            titleLabel.textAlignment = .center
            titleLabel.sizeToFit()
            titleLabel.center.x = onView.center.x
            titleLabel.top = img.bottom
            onView.addSubview(titleLabel)
            
        } else {
            guard let testScores = viewmodel.testScores else { print("damn"); return }
            let titleLabel = UILabel()
            titleLabel.text = "Test Scores"
            titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
            titleLabel.adjustsFontForContentSizeCategory = true
            titleLabel.textColor = UIColor.white
            titleLabel.textAlignment = .center
            titleLabel.sizeToFit()
            titleLabel.left = CGFloat.zero.addPadding()
            titleLabel.top = CGFloat.zero.addPadding()
            onView.addSubview(titleLabel)
            
            // testers count
            let testersLabel = UILabel()
            testersLabel.text = testScores.numOfSatTestTakers + " testers"
            testersLabel.font = UIFont.preferredFont(forTextStyle: .body)
            testersLabel.adjustsFontForContentSizeCategory = true
            testersLabel.textColor = UIColor.gray
            testersLabel.textAlignment = .center
            testersLabel.sizeToFit()
            testersLabel.left = titleLabel.left
            testersLabel.top = titleLabel.bottom
            onView.addSubview(testersLabel)
            // grades (reading, writing, math)
            
            let gradeCard = UIView(withColor: UIColor.white.withAlphaComponent(0.15))
            gradeCard.layer.cornerRadius = 10
            gradeCard.layer.masksToBounds = true
            gradeCard.width = onView.width.subtractPadding(.xXLarge, multiplier: 2)
            gradeCard.height = onView.height / 2.75
            onView.addSubview(gradeCard)
            gradeCard.center.x = onView.width / 2
            gradeCard.top = testersLabel.bottom.addPadding(.xXLarge)
                
                
            // reading section
            // icon
            let readingIcon = ContentIcon(type: .reading, size: .xxXLarge, light: false)
            // label
            let readingLbl = UILabel()
            readingLbl.text = testScores.satCriticalReadingAvgScore + " avg."
            readingLbl.font = UIFont.preferredFont(forTextStyle: .headline)
            readingLbl.adjustsFontForContentSizeCategory = true
            readingLbl.textColor = UIColor.gray
            readingLbl.textAlignment = .center
            readingLbl.sizeToFit()
            // set
            readingLbl.left = CGFloat.zero.addPadding(.xLarge)
            readingIcon.centerY = (gradeCard.height / 2.5)
            readingIcon.centerX = (readingLbl.centerX)
            readingLbl.top = readingIcon.bottom.addPadding()
            // add
            gradeCard.addSubview(readingIcon)
            gradeCard.addSubview(readingLbl)
            // style line
            let readingLine = createStyleLine()
            readingLine.centerY = gradeCard.height / 2.5
            readingLine.left = readingLbl.right.addPadding()
            gradeCard.addSubview(readingLine)
            
            // writing section
            // icon
            let writingIcon = ContentIcon(type: .writing, size: .xxXLarge, light: false)
            // label
            let writingLbl = UILabel()
            writingLbl.text = testScores.satWritingAvgScore + " avg."
            writingLbl.font = UIFont.preferredFont(forTextStyle: .headline)
            writingLbl.adjustsFontForContentSizeCategory = true
            writingLbl.textColor = UIColor.gray
            writingLbl.textAlignment = .center
            writingLbl.sizeToFit()
            // set
            writingLbl.left = readingLine.right.addPadding()
            writingIcon.centerY = (gradeCard.height / 2.5)
            writingIcon.centerX = (writingLbl.centerX)
            writingLbl.top = writingIcon.bottom.addPadding()
            // add
            gradeCard.addSubview(writingIcon)
            gradeCard.addSubview(writingLbl)
            // style line
            let writingLine = createStyleLine()
            writingLine.centerY = gradeCard.height / 2.5
            writingLine.left = writingLbl.right.addPadding()
            gradeCard.addSubview(writingLine)
            
            // math section
            // icon
            let mathIcon = ContentIcon(type: .reading, size: .xxXLarge, light: false)
            // label
            let mathLbl = UILabel()
            mathLbl.text = testScores.satCriticalReadingAvgScore + " avg."
            mathLbl.font = UIFont.preferredFont(forTextStyle: .headline)
            mathLbl.adjustsFontForContentSizeCategory = true
            mathLbl.textColor = UIColor.gray
            mathLbl.textAlignment = .center
            mathLbl.sizeToFit()
            // set
            mathLbl.left = writingLine.right.addPadding(.medium)
            mathIcon.centerY = (gradeCard.height / 2.5)
            mathIcon.centerX = (mathLbl.centerX)
            mathLbl.top = mathIcon.bottom.addPadding()
            // add
            gradeCard.addSubview(mathIcon)
            gradeCard.addSubview(mathLbl)
            
        }
        
        
        
        
    }
    
    func createStyleLine() -> UIView {
        let v = UIView(withColor: Colors.lightGray)
        v.frame.size = .init(4, 45)
        v.layer.cornerRadius = 2
        v.layer.masksToBounds = true
        
        return v
    }
}



extension SchoolDetailController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}



