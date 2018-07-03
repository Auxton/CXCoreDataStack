//
//  AppDelegate.swift
//  CXCoreDataStack
//
//  Created by Augustine Odiadi on 27/06/2018.
//  Copyright © 2018 Augustine Odiadi. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var coreDataCommon = CXCoreDataCommons.sharedInstance

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        coreDataCommon.dataStack.commit()
    }

}

