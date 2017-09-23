//
//  cvvGrade.swift
//  CVV API
//
//  Created by Vittorio Grasso on 23/06/17.
//  Copyright © 2017 Vittorio Grasso. All rights reserved.
//

import Foundation

class cvvGrade {
    var date: String?
    var type: cvvGradeType?
    var grade: Float?
    
    init(date: String, type: cvvGradeType, grade: String) {
        self.date = date
        self.type = type
        self.grade = self.strGradeToFloat(grade: grade)
    }
    
    convenience init(date: String, type: cvvGradeType, grade: Float) {
        self.init(date: date,type: type, grade: String(grade))
    }
    
    func strGradeToFloat(grade: String) -> Float? {
        var minusToDelete: Float = 0
        var cvGrade = grade.replacingOccurrences(of: "+", with: ".15")
        cvGrade = cvGrade.replacingOccurrences(of: "½", with: ".5")
        var new  = ""
        var done = false
        cvGrade.characters.map {
            if($0 != "/" && !done) {
                new += String($0)
            } else {
                new += (done ? "" : ".75")
                done = true
            }
        }
        cvGrade = new
        if(cvGrade.range(of: "-") != nil) {
            minusToDelete = 0.15
            cvGrade = cvGrade.replacingOccurrences(of: "-", with: "")
        }
        let final_grade = Float(cvGrade)
        return (final_grade!-minusToDelete)
    }
}
