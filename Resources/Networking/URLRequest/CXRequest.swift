//
//  MFSRequest.swift
//  MyFirstSlideshow
//
//  Created by Augustine Odiadi on 11/12/2017.
//  Copyright © 2017 Yoti. All rights reserved.
//

import Foundation

extension NSURLRequest {
    
    class func requestWithParameters(params:CXRequestParams) ->NSURLRequest{
        
        let url = URL(string:(params.endpoint!), relativeTo:URL(string:(params.baseURL)!))
        let request = NSMutableURLRequest(url:url!)
        
        request.httpMethod = params.method()!
   
        if let body = params.body {
            request.httpBody = try! JSONSerialization.data(withJSONObject:body, options:JSONSerialization.WritingOptions.prettyPrinted)
        }
        
        if let headers = params.headers {
            for (key, value) in headers{
                request.addValue(value as! String, forHTTPHeaderField:key)
            }
        }
        
        request.httpShouldHandleCookies = true
        return request;
    }
}

extension String{
        func get(parameters:CXRequestParams, completion: @escaping (CXResponse) -> ()) {
            
        parameters.endpoint     = self
        parameters.HTTPMethod   = .GET
        let request: URLRequest = NSURLRequest.requestWithParameters(params:parameters) as URLRequest
            
        let task = URLSession.sharedCXSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            completion(CXResponse(data:data, error:error, response:response))
        })
        task.resume()
    }
}

struct CXResponse {
    
    let data: Data?
    var error: Error?
    let response: URLResponse?
    
    var prettyPrinted: AnyObject? {
        
        if let d =  data {
            return try! JSONSerialization.jsonObject(with: d, options: []) as AnyObject
        }
        
        return nil
    }
    
    var code: Int? {
        if let response = response {
            return (response as! HTTPURLResponse).statusCode
        }
        
        return nil
    }
    
    var errorMsg: String? {
        if let error = error {
            return error.localizedDescription
        }
        
        return nil
    }
    
    var ok: Bool? {
        
        if let code = self.code {
            
            switch (code){
            case 200...299:
                return true
            case 300...500:
                return false
            default:
                return false
            }
        }
        
        return false
    }
}
