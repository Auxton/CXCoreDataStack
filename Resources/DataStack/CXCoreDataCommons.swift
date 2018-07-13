//
//  CXCoreDataFetch.swift
//  CXCoreDataStack
//
//  Created by Augustine Odiadi on 29/06/2018.
//  Copyright © 2018 Augustine Odiadi. All rights reserved.
//

import UIKit
import CoreData

class CXCoreDataCommons {
    static let sharedInstance = CXCoreDataCommons()
    var dataStack: CXCoreDataStack
    
    private init() {
        dataStack = CXCoreDataStack(cdmodel: "CXCoreDataStack")
    }
}


// MARK: Public
extension CXCoreDataCommons {
    
    func get<T: NSManagedObject>(context: StackContext, predicate: NSPredicate? = nil, descriptor: NSSortDescriptor? = nil, completion: @escaping (Error? , [T]?) -> ()) {
        let request: NSFetchRequest< T > = T.fetchRequest() as! NSFetchRequest< T >
        
        request.predicate = predicate
        
        context.perform {
            let array: [ T ] = try! request.execute()
            
            completion(nil, array)
        }
    }
    
    func get<T: NSManagedObject>(completion: @escaping (Error?, [T]?) -> ()) {
        
        self.get(context: dataStack.context()) { (error, object: [ T ]?) in
            completion(error, object)
        }
    }
    
    func insert<T: NSManagedObject>(instance: [ [String : Any] ], completion: @escaping (NSError?, T?) -> () = {_,_  in }) {
        
        var keys: [String] = [String]()
        T.entity().attributesByName.enumerated().forEach { keys.append($0.element.key) }
        
        let context: StackContext = dataStack.context()
        
        context.perform {
            
            instance.forEach({ (person) in
                let eName: String = NSStringFromClass( T.self )
                let instance = NSEntityDescription.insertNewObject(forEntityName: eName, into: context)
                
                keys.forEach({ (key) in
                    instance.setValue(person[key], forKey: key)
                })
            })
            
            try! context.save()
            
            self.dataStack.commit(completion: { (success, error) in
                completion( error, nil )
            })
        }
    }
}


