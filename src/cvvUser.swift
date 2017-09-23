//
//  cvvUser.swift
//  CVV API
//
//  Created by Vittorio Grasso on 23/06/17.
//  Copyright © 2017 Vittorio Grasso. All rights reserved.
//

import Foundation

class cvvUser {
    var sessionId: String = ""
    var status: String = "OK"
    var name: String? = ""
    var school: String? = ""
    private var grades: [cvvGrade]?
    
    init(sessionId: String) {
        let apiResult = cvvAPI.apiGetRequest(args: [sessionId])
        if(apiResult.status == "error") {
            self.status = "error"
            return
        }
        self.sessionId = sessionId
        self.name = apiResult.result?["name"].string
        self.school = apiResult.result?["school"].string
    }
    
    convenience init(username: String, password: String, mode: String?, custcode: String = "SPAGGIARI") {
        let sessionId = cvvAPI.apiGetSessionId(username: username, password: password, mode: mode, custcode: custcode)
        self.init(sessionId: sessionId.sessionId!)
    }
    
    func loadGrades() {
        // TODO: write it
    }
}
