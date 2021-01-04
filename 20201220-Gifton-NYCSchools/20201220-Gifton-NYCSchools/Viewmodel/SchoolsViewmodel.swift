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
    private var _testScores: AllTestaScores = []
    private var _schools: Schools = []
    
    // MARK: public vars
    public var schools: [SchoolCellViewModel] { return _schools.toViewmodels() }
    public var testScores: AllTestaScores { return _testScores }
    
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
            let schools = try Schools.init(fromURL: URL.Endpoints.allSchools)
            _schools.append(contentsOf: schools)
            
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
            let newScores = try AllTestaScores.init(fromURL: URL.Endpoints.testScores)
            _testScores.append(contentsOf: newScores)
            
            print(_testScores.count, _schools.count)
            
            
            for score in _testScores {
                
                var currentSchool = schools.schools.first {
                    
                    $0.dbn == score.dbn
                    
                }
                
                currentSchool?.setScores(score)
            }
            
            
        } catch(let err) {
            print(err)
        }
    }
    
    public func viewSchool(atIndex index: Int) -> School {
        
        var school = _schools[index]
        
        if (school.testScores == nil) {
            guard let scores = _testScores.first(where: { (ts) -> Bool in
                ts.dbn == school.dbn
            }) else { return school }
            
            school.setScores(scores)
        }
        
        return school
    }
    
    
    // return school from index to assign test schores, orretrieve info from tapped cell
    func school(index: Int) -> School? {
        
        var school = _schools[index]
        
        if school.testScores != nil { return school }
        
        let scores = testScores.first(where: { (ts) -> Bool in
            ts.dbn == school.dbn
        })
        
        if let score = scores {
            school.setScores(score)
        }
        
        return nil
    }
    
}
