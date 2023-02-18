//
//  StudyPlan.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 16/01/23.
//

import UIKit

class StudyPlan: Codable {
    let topic: String
    let subjectName: String
    let date: Date
    var done: Bool = false
    let id: String
    let note: Note
    
    init(topic: String, subjectName: String, date: Date, done: Bool, id: String, note: Note) {
        self.topic = topic
        self.subjectName = subjectName
        self.date = date
        self.done = done
        self.id = id
        self.note = note
    }
}
