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
                request.addValue(value, forHTTPHeaderField:key)
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
        
        let task = URLSession.sharedCXSession.dataTask(with:NSURLRequest.requestWithParameters(params:parameters) as URLRequest) {
            data, response, sessionError in
        
            var mResponse = CXResponse(data:data!, error:nil, response:response)
            if !(mResponse.ok)! {
                mResponse.error = NSError(domain:"CX", code:0000, userInfo:[NSLocalizedDescriptionKey:"Request Unsuccessful!"])
            }
            completion(mResponse)
        }
        task.resume()
    }
}

struct CXResponse {
    
    let data: Data
    var error: NSError?
    let response: URLResponse?
    
    var prettyPrinted: AnyObject? {
        return try! JSONSerialization.jsonObject(with: data, options: []) as AnyObject
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
