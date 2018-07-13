//
//  ViewController.swift
//  CXCoreDataStack
//
//  Created by Augustine Odiadi on 27/06/2018.
//  Copyright © 2018 Augustine Odiadi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var sharedDataStack: CXCoreDataCommons = CXCoreDataCommons.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let params = CXRequestParams(baseURL: "https://staging.iaustyn.com/parking/api/")
        
        "users".get(parameters: params) { (response) in
            
            guard let persons: [ [String : Any] ] = response.prettyPrinted as? [ [String : Any] ] else {
                return
            }

            print("\(String(describing: response.prettyPrinted))")
            self.sharedDataStack.insert(instance: persons, completion: { (error, person:Person?) in

                self.sharedDataStack.get(completion: { (error2, persons:[Person]?) in
                    
                })
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

