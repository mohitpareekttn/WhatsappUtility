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

public class CoreDataManager {
  
    static let sharedManager = CoreDataManager()

    private init() {} // Prevent clients from creating another instance.
  
    private let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    
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
        
        //creating a new record
        let newMessage = Messages(context: managedContext)
        newMessage.message = message
        newMessage.messageTitle = title
        
        //save the data after creating it
        saveData()
    }
    
    func createHistory(number: String, message: String) {
        //creating a new record
        let newNumber = History(context: managedContext)
        newNumber.message = message
        newNumber.number = number
        
        //save the data after creating it
        saveData()
    }
    
    func saveData() {
        do {
            try self.managedContext.save()
        } catch {
            print("error in saving the data")
        }
    }
    
    func fetchMessages() -> [Messages] {
        var messages: [Messages]?
        
        //fetch the data from core data
        do {
            messages = try managedContext.fetch(Messages.fetchRequest())
        } catch {
            print("fetching of messages failed")
        }
        return messages ?? []
    }
    
    func fetchHistory() -> [History] {
        var history: [History]?
        
        //fetch the data from core data
        do {
            history = try managedContext.fetch(History.fetchRequest())
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
