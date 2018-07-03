//
//  MFSSession.swift
//  MyFirstSlideshow
//
//  Created by Augustine Odiadi on 11/12/2017.
//  Copyright © 2017 Yoti. All rights reserved.
//

import Foundation
extension URLSession {
    
    class var sharedCXSession: URLSession {
        
        struct CXSession {
            static let session = URLSession(
                configuration:  URLSessionConfiguration.configuration(),
                delegate:       CXSessionDelegate(),
                delegateQueue:  OperationQueue.main)
        }
        return CXSession.session
    }
}

class CXSessionDelegate: NSObject, URLSessionDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        CXAuth.auth(with: challenge) { response in
            completionHandler(response.challenge!, response.credentials)
        }
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
    }
}
