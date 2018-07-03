//
//  CXExecuteTimer.swift
//  CXCoreDataStack
//
//  Created by Augustine Odiadi on 03/07/2018.
//  Copyright © 2018 Augustine Odiadi. All rights reserved.
//

import UIKit

class CXDebug {

    private static var tickTimestamp: Date = Date()
    
    static func tick() {
        print("TICK.")
        tickTimestamp = Date()
    }
    
    static func tock() {
        print("TOCK. Elapsed Time: \(Date().timeIntervalSince(tickTimestamp))")
    }
}
