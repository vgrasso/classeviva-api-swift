//
//  cvvAPI.swift
//  CVV API
//
//  Created by Vittorio Grasso on 23/06/17.
//  Copyright © 2017 Vittorio Grasso. All rights reserved.
//

import Foundation

class cvvAPI: NSObject {
    static var APIUrl: String = "path/to/ClassevivaAPI"
    
    static func apiGetSessionId(username: String, password: String, mode: String?, custcode: String = "SPAGGIARI") -> (status: String, sessionId: String?) {
        let action = custcode + "/" + username + "/" + password + (mode != nil ? "/" + mode! : "")
        let apiActionURL = URL(string: (APIUrl + action))
        do {
            let apiResult = try String(contentsOf: apiActionURL!, encoding: String.Encoding.utf8)
            let jsonApiResult = JSON(data: apiResult.data(using: String.Encoding.utf8, allowLossyConversion: false)!)
            
            if(jsonApiResult["status"].string == "error") {
                return ("error", nil)
            }
            
            let sessionId = jsonApiResult["sessionId"].string
            
            return ("OK", sessionId)
            
        } catch _ as NSError {
            return ("error", nil)
        }
    }
    
    static func apiGetRequest(args: [String]) -> (status: String, result: JSON?) {
        var action = ""
        for arg in args {
            action += arg + "/"
        }
        let apiActionURL = URL(string: (APIUrl + action))
        do {
            let apiResult = try String(contentsOf: apiActionURL!, encoding: String.Encoding.utf8)
            let jsonApiResult = JSON(data: apiResult.data(using: String.Encoding.utf8, allowLossyConversion: false)!)
            
            if(jsonApiResult["status"].string == "error") {
                return ("error", nil)
            }
            
            return ("OK", jsonApiResult)
            
        } catch _ as NSError {
            return ("error", nil)
        }
    }
    
    /// DEPRECATED DO NOT USE
    
    static func apiReturnIsError(jsonApiResult: [String:AnyObject]?) -> Bool {
        guard let _ = jsonApiResult!["status"] as? String else {
            return true
        }
        return false;
    }
    
    /// DEPRECATED DO NOT USE
    
    private static func unwrapJsonResult(jsonApiResult: [String:AnyObject]) -> [String:Any] {
        var unwrappedResult = [String:Any]()
        for (key, value) in jsonApiResult {
            if(self.isArray(value: value)) {
                unwrappedResult[key] = self.unwrapJsonResult(jsonApiResult: value as! [String : AnyObject])
            } else {
                unwrappedResult[key] = (value as? String)
            }
        }
        return unwrappedResult
    }
    
    static func isArray(value: AnyObject) -> Bool {
        return value is [AnyObject]
    }
}
