//
//  SchoolsViewModel.swift
//  20201220-Gifton-NYCSchools
//
//  Created by Gifton on 12/20/20.
//

import Foundation


class SchoolsViewmodel: Viewmodel {
    func refresh(completion: () -> ()) {
        ///
        downloadSchools(completion: nil)
        completion()
    }
    
    // MARK: Private vars
    private var _testScores: AllTestaScores?
    private var _schools: Schools?
    
    // MARK: public vars
    public var schools: Schools? { return _schools }
    public var testScores: AllTestaScores? { return _testScores }
    
    
}



extension SchoolsViewmodel {
    
    // recieve schools
    func downloadSchools(completion: ((Error?, Schools?) -> ())?) {
        do {
            _schools = try Schools.init(fromURL: URL.Endpoints.allSchools)
            DispatchQueue.main.async {
                completion?(nil, self.schools)
                self.downloadTestScores()
            }
            
        } catch (let err) {
            print(err)
            DispatchQueue.main.async {
                completion?(err, nil)
            }
        }
    }
    
    // recieve test scores
    func downloadTestScores() {
        do {
            _testScores = try AllTestaScores.init(fromURL: URL.Endpoints.testScores)
        } catch(let err) {
            print(err)
        }
    }
    
    
    func school(index: Int) -> School {
        guard let schools = schools else { return }
        let school = schools[index]
        let scores = testScores?.first(where: { (ts) -> Bool in
            ts.dbn == school.dbn
        })
        if let score = scores {
            school.testScores = score
        }
    }
    
}
