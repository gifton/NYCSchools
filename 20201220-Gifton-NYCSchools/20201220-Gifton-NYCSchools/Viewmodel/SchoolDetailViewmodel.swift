//
//  SchoolDetailViewmodel.swift
//  20201220-Gifton-NYCSchools
//
//  Created by Gifton on 12/20/20.
//

import Foundation

class SchoolDetailViewmodel: Viewmodel {
    
    var uuid: UUID {
        return UUID()
    }
    
    var id: String {
        return school.dbn + "Detail"
    }
    
    static func == (lhs: SchoolDetailViewmodel, rhs: SchoolDetailViewmodel) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    func refresh(completion: () -> ()) {
        
        
    }
    
    init(school: School) {
        assert(school.testScores != nil)
        
        self.school = school
        
    }
    
    private var school: School
    
    
    public var schoolName: String {
        return school.schoolName
    }
    
    public var overview: String {
        return school.overviewParagraph
    }
    
    public var location: String {
        return school.location
    }
    
    public var website: URL? {
        return URL(string: school.website)
    }
    
    public var testScores: TestScores? {
        return school.testScores
    }
    
    
}
