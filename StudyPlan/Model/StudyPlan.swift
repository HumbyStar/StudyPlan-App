//
//  StudyPlan.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 16/01/23.
//

import Foundation

class StudyPlan: Codable {
    var course: String
    var section: String
    var date: Date
    var done: Bool = false
    var id: String //MARK: ID, PRECISO DO ID, ID ,ID , ID, ID, ID
    
    init(course: String, section: String, date: Date, done: Bool, id: String) {
        self.course = course
        self.section = section
        self.date = date
        self.done = done
        self.id = id
    }
    
    func scheduleForgettingCurve() {
        let date = date
    }
}
