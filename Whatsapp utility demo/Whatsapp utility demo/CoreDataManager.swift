//
//  CoreData.swift
//  Whatsapp utility demo
//
//  Created by MOHIT PAREEK on 06/11/20.
//  Copyright © 2020 MOHIT PAREEK. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
  
    static let sharedManager = CoreDataManager()

    private init() {} // Prevent clients from creating another instance.
  
    static let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    lazy var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "Model")
    
    
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
        return container
    }()
    
    
    func createMessage(title: String, message: String) {
        
        let counter = UserDefaults.standard.integer(forKey: "messageCounter")
        
        
        //creating a new record
        let newMessage = Messages(context: CoreDataManager.managedContext)
        newMessage.message = message
        newMessage.messageTitle = title
        newMessage.counter = Int64(counter + 1)
        
        UserDefaults.standard.setValue(counter + 1, forKey: "messageCounter")
        
    }
    
    func updateMessage(title: String, message: String, counter: Int64) {
        let updatedMessage = Messages(context: CoreDataManager.managedContext)
        updatedMessage.message = message
        updatedMessage.messageTitle = title
        updatedMessage.counter = counter
    }
    
    func createHistory(number: String, message: String) {
        
        let counter = UserDefaults.standard.integer(forKey: "historyCounter")
        //creating a new record
        let newNumber = History(context: CoreDataManager.managedContext)
        newNumber.message = message
        newNumber.number = number
        newNumber.counter = Int64(counter + 1)
        
        UserDefaults.standard.setValue(counter + 1, forKey: "historyCounter")
        //save the data after creating it
        //saveData()
    }
    
    func saveData() {
        do {
            try CoreDataManager.managedContext.save()
        } catch {
            print("error in saving the data")
        }
    }
    
    func fetchMessages() -> [Messages] {
        var messages: [Messages]?
        
        //fetch the data from core data
        let freq = NSFetchRequest<NSFetchRequestResult>(entityName: "Messages")
        let sortDescriptor = NSSortDescriptor(key: "counter", ascending: true)
        freq.sortDescriptors = [sortDescriptor]
        
        do {
//            messages = try CoreDataManager.managedContext.fetch(Messages.fetchRequest())
            let fetchedResults: [Messages] = try CoreDataManager.managedContext.fetch(freq) as! [Messages]
            if let results: [Messages] = fetchedResults {
                messages = results
            }
        } catch {
            print("fetching of messages failed")
        }
        return messages ?? []
    }
    
    func fetchHistory() -> [History] {
        var history: [History]?
        
        //fetch the data from core data
        let freq = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
        let sortDescriptor = NSSortDescriptor(key: "counter", ascending: true)
        freq.sortDescriptors = [sortDescriptor]
        do {
            //history = try CoreDataManager.managedContext.fetch(History.fetchRequest())
            let fetchedResults: [History] = try CoreDataManager.managedContext.fetch(freq) as! [History]
            if let results: [History] = fetchedResults {
                history = results
            }
        } catch {
            print("fetching of messages failed")
        }
        return history ?? []
        
    }
}
//class CoreData {
//
//    private let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
//
//
//    func createMessage(title: String, message: String) {
//
//        //creating a new record
//        let newMessage = Messages(context: managedContext!)
//        newMessage.message = message
//        newMessage.messageTitle = title
//
//        //save the data after creating it
//        saveData()
//    }
//
//    func createHistory(number: String, message: String) {
//        //creating a new record
//        let newNumber = History(context: managedContext!)
//        newNumber.message = message
//        newNumber.number = number
//
//        //save the data after creating it
//        saveData()
//    }
//
//    func saveData() {
//        do {
//            try self.managedContext?.save()
//        } catch {
//            print("error in saving the data")
//        }
//    }
//
//    func fetchMessages() -> [Messages] {
//        var messages: [Messages]?
//
//        //fetch the data from core data
//        do {
//            messages = try managedContext?.fetch(Messages.fetchRequest())
//        } catch {
//            print("fetching of messages failed")
//        }
//        return messages ?? []
//    }
//
//    func fetchHistory() -> [History] {
//        var history: [History]?
//
//        //fetch the data from core data
//        do {
//            history = try managedContext?.fetch(History.fetchRequest())
//        } catch {
//            print("fetching of messages failed")
//        }
//        return history ?? []
//
//    }
//}

//fileprivate lazy var fetchedResultController1: NSFetchedResultsController<UserImageData> =
//    {
//        let appDelegate = UIApplication.shared.delegate as? AppDelegate
//        let context = appDelegate?.persistentContainer.viewContext
//        let fetchRequest:NSFetchRequest = UserImageData.fetchRequest()
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "urlImage", ascending: false)]
//        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
//        fetchResultController.delegate = self
//        try! fetchResultController.performFetch()
//        return fetchResultController as! NSFetchedResultsController<UserImageData>
//    }()
