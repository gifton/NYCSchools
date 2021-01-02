
import Foundation


class SchoolCellViewModel: Viewmodel {
    
    func refresh(completion: () -> ()) {
        
    }
    
    init(school: School) {
        self.school = school
        testScores = school.testScores
    }
    
    var school: School
    var testScores: TestScores?
    
    static func == (lhs: SchoolCellViewModel, rhs: SchoolCellViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    var uuid: UUID {
        return UUID()
    }
    
    var id: String {
        return school.dbn
    }
    
}


extension Array where Element == School {
    func toViewmodels() -> [SchoolCellViewModel] {
        var out = [SchoolCellViewModel]()
        
        forEach { out.append(SchoolCellViewModel(school: $0)) }
        
        return out
    }
}

extension Array where Element == SchoolCellViewModel {
    var schools: Schools {
        var out = Schools()
        forEach { out.append($0.school) }
        return out
    }
}
