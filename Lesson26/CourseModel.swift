//
//  Course.swift
//  Lesson26
//
//  Created by Владислав Пуцыкович on 27.01.22.
//

import Foundation

class Course {
    var courseName: String
    var subject: String
    var industry: String
    var teacher: String
    var users: [User]?
    
    init(courseName: String, subject: String, industry: String, teacher: String, users: [User]) {
        self.courseName = courseName
        self.subject = subject
        self.industry = industry
        self.teacher = teacher
        self.users = users
    }
}
