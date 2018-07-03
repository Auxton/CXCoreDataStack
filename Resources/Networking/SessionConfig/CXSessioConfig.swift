//
//  MFSSessioConfig.swift
//  MyFirstSlideshow
//
//  Created by Augustine Odiadi on 11/12/2017.
//  Copyright © 2017 Yoti. All rights reserved.
//

import Foundation

extension URLSessionConfiguration{
    static let kSessiontimeOut:UInt = 60
    
    class func configuration() -> URLSessionConfiguration{
        return CXConfiguration(headers:[:])
    }
    
    class func CXConfiguration(headers:Any?) -> URLSessionConfiguration{
        let config = URLSessionConfiguration.default
        
        config.timeoutIntervalForRequest    = TimeInterval(kSessiontimeOut)
        config.timeoutIntervalForResource   = TimeInterval(kSessiontimeOut)
        config.httpAdditionalHeaders        = (headers as! [AnyHashable : Any])
        config.httpShouldUsePipelining      = true
        config.allowsCellularAccess         = true
        return config
    }
}
