//
//  MFSRequestParams.swift
//  MyFirstSlideshow
//
//  Created by Augustine Odiadi on 11/12/2017.
//  Copyright © 2017 Yoti. All rights reserved.
//

import UIKit

enum CXHTTPMethod: Int {
    case GET
    case PUT
    case POST
    case DELETE
};

class CXRequestParams {
    
    var body: Dictionary<String, Any>?
    var baseURL: String?
    var endpoint: String?
    var HTTPMethod: CXHTTPMethod?
    var headers: [String: Any]?
    var miscellaneous: [String: Any]?
    
     init(baseURL: String, body: Dictionary<String, Any>? = nil, headers:[String: Any]? = nil) {
        
        if let bdy = body {
            self.body = bdy
        }
        
        self.baseURL = baseURL
        
        if let hdrs = headers {
            self.headers = hdrs
        }
        else{
            self.headers = CXRequestParams.basic()
        }
    }
    
    class func basic() -> [String: String] {
        var header = [String: String]()
        
        header["Accept"]        = "application/json"
        header["Content-Type"]  = "application/json"
        
        return header
    }
    
    func method() -> String?  {
        
        switch (self.HTTPMethod) {
        case .GET?: return "GET"
        case .PUT?: return "PUT"
        case .POST?: return "POST"
        case .DELETE?: return "DELETE"
        case .none: break
        }
        
        return nil
    }
    
}
