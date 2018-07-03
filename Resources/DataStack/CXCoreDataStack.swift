//
//  CXCoreDataStack.swift
//  CXCoreDataStack
//
//  Created by Augustine Odiadi on 27/06/2018.
//  Copyright © 2018 Augustine Odiadi. All rights reserved.
//

import CoreData
typealias StackContext = NSManagedObjectContext

class CXCoreDataStack {
    
    fileprivate let model: String
    
    lazy var mainContext: NSManagedObjectContext = {
        return self.container.viewContext
    }()
    
    private lazy var new: NSManagedObjectContext = {
        var context: NSManagedObjectContext = self.privateContext()
        
        context.parent = self.writeContext
        context.mergePolicy  = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        
        return context
    }()
    
    fileprivate var writeContext: NSManagedObjectContext
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.model)
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    init(cdmodel: String? = nil) {
        self.model = cdmodel!
        
        writeContext = NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
        writeContext.persistentStoreCoordinator = self.container.persistentStoreCoordinator
        
        setMergePolicies()
        NotificationCenter.default.addObserver(self, selector: #selector(mergeChanges(changes:)), name: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: nil)
    }
    
    func setMergePolicies () {
        
        mainContext.mergePolicy  = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        writeContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
    }
    
    @objc private func mergeChanges(changes: Notification)  {
        
        let context: NSManagedObjectContext = changes.object as! NSManagedObjectContext
        
        guard changes.userInfo != nil, context != self.writeContext else {
            return
        }
        
        self.mainContext.perform {
            self.mainContext.mergeChanges(fromContextDidSave: changes)
        }
    }
}

// MARK: Internal
extension CXCoreDataStack {
    
    func commitMM (completion: (Bool?, NSError?) -> () = { _,_  in }) {
        
        guard mainContext.hasChanges else {
            completion(true, nil);  return
        }
        
        var error: NSError?
        
        do {
            try mainContext.save()
        }
        catch let nserror as NSError {
            error = nserror
        }
        
        completion(!(error != nil), error)
    }
    
    func commit (completion: (Bool?, NSError?) -> () = {_,_ in}) {
        
        guard writeContext.hasChanges else {
            completion(true, nil); return
        }
        
        do {
            try writeContext.save()
            
            commitMM { (success, error) in
                completion(!(error != nil), error)
            }
        }
        catch let nserror as NSError {
            completion(false, nserror)
        }
    }
}

// MARK: Private
extension CXCoreDataStack {
    
    func privateContext() -> NSManagedObjectContext {
        return NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
    }
}

// MARK: Public
extension CXCoreDataStack {
    
    func context() -> StackContext {
        let newContext: StackContext = self.new
        
        func context () -> StackContext {
            newContext.perform {
                newContext.undoManager = nil
            }
            
            return newContext
        }
        
        return context()
    }
}

