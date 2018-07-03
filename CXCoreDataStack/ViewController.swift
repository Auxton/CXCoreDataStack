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

        let params   = CXRequestParams(baseURL: "https://app-staging.studentswipe.co.uk.")
        let endpoint = "api/test?Authorization=ace2244c995e4a7d077009d15ed2d1afc1f84fb1ceba52b3f49d7a6fc06e50c2"
        
        endpoint.get(parameters: params) { (response) in
            
            guard let persons: [ [String : Any] ] = response.prettyPrinted as? [ [String : Any] ] else {
                return
            }

            self.sharedDataStack.insert(persons: persons, completion: { (error, person:Person?) in

                self.sharedDataStack.get(completion: { (error2, persons:[Person]?) in
                    print("")
                })
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

