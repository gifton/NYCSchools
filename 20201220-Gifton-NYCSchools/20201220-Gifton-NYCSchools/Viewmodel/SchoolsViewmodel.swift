//
//  SchoolsViewModel.swift
//  20201220-Gifton-NYCSchools
//
//  Created by Gifton on 12/20/20.
//

import Foundation

class SchoolsViewmodel: Viewmodel {
    
    var uuid: UUID {
        return UUID()
    }
    
    var id: String {
        return "schoolCVM"
    }
    
    static func == (lhs: SchoolsViewmodel, rhs: SchoolsViewmodel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func refresh(completion: () -> ()) {
        ///
        downloadSchools(completion: nil)
        completion()
    }
    
    // MARK: Private vars
    private var _testScores: AllTestaScores?
    private var _schools: Schools?
    
    // MARK: public vars
    public var schools: [SchoolCellViewModel]? { return _schools?.toViewmodels() }
    public var testScores: AllTestaScores? { return _testScores }
    
    public func start(completion: @escaping (Error?) -> ()) {
        downloadSchools { (err) in
            self.assignTestScores()
            completion(err)
            
        }
    }
    
}



extension SchoolsViewmodel {
    
    // recieve schools
    func downloadSchools(completion: ((Error?) -> ())?) {
        
        do {
            _schools = try Schools.init(fromURL: URL.Endpoints.allSchools)
            
            completion?(nil)
            
            
        } catch (let err) {
            DispatchQueue.main.async {
                completion?(err)
            }
        }
    }
    
    // recieve test scores
    func assignTestScores() {
        do {
            _testScores = try AllTestaScores.init(fromURL: URL.Endpoints.testScores)
            guard let scores = _testScores, let schools = schools else { return }
            
            print(scores.count, schools.count)
            
            for score in scores{
                var currentSchool = schools.schools.first { $0.dbn == score.dbn }
                currentSchool?.setScores(score)
            }
            
        } catch(let err) {
            print(err)
        }
    }
    
    
    // return school from index to assign test schores, orretrieve info from tapped cell
    func school(index: Int) -> School? {
        
        guard let _schools = _schools else { print("couldnt find school"); return nil }
        var school = _schools[index]
        
        if school.testScores != nil { print("returning school"); return school }
        
        let scores = testScores?.first(where: { (ts) -> Bool in
            ts.dbn == school.dbn
        })
        
        if let score = scores {
            school.setScores(score)
        }
        
        return nil
    }
    
}
