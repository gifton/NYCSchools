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
        
        self.school = school
        
    }
    
    private var school: School
    
    
    public var schoolName: String {
        return school.schoolName
    }
    
    public var phone: String {
        return school.phoneNumber
    }
    
    public var overview: String {
        return school.overviewParagraph
    }
    
    public var location: String {
        // quick fix didnt realize locaiton includes longitude & latitude,
        // cutting it out of string instead of taking the time to find another object variable that satisfies reqs better
        return String(school.location.split(separator: "(")[0])
    }
    
    public var website: URL? {
        return URL(string: school.website)
    }
    
    public var testScores: TestScores? {
        return school.testScores
    }
    
    
}
