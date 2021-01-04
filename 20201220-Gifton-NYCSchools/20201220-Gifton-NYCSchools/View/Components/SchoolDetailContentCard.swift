
import UIKit



final class SchoolDetailContentCard {
    
    internal init(school: School, type: SchoolDetailContentCard.ContentType) {
        self.school = school
        self.type = type
    }
    
    enum ContentType {
        case overview, location, grades
    }
    
    private var school: School
    private var type: ContentType
    
    private var title: UILabel!
}



private extension SchoolDetailContentCard {
    func setView() {
        
    }
    
    func setTitle() {
        
    }
    
    func setOverview() {
        
    }
    
    func setLocation() {
        
    }
    
    func setGrades() {
        
    }
}
