//
//  MFSAuth.swift
//  MyFirstSlideshow
//
//  Created by Augustine Odiadi on 12/12/2017.
//  Copyright © 2017 Yoti. All rights reserved.
//

import UIKit

class CXAuth {

    class func auth(with challenge:URLAuthenticationChallenge, completion:@escaping (AuthResponse) -> Void){
        completion(AuthResponse(challengeType: challenge))
    }
}

struct AuthResponse {
    var challengeType: URLAuthenticationChallenge?
    
    var challenge: URLSession.AuthChallengeDisposition? {
        // Add unique / custom qualifying condition(s)
        return .performDefaultHandling
    }
    
    var credentials: URLCredential{
        // Add unique / custom qualifying condition(s)
        return URLCredential(trust:(challengeType?.protectionSpace.serverTrust)!)
    }
}
