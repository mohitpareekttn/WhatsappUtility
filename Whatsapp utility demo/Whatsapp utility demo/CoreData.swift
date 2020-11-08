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

class CoreData {
    
    private let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    
    func createData(title: String, message: String) {
        
        //creating a new record
        let newMessage = Messages(context: managedContext!)
        newMessage.message = message
        newMessage.messageTitle = title
        
        //save the data after creating it
        saveData()
    }
    
    func saveData() {
        do {
            try self.managedContext?.save()
        } catch {
            print("error in saving the data")
        }
    }
    
    func fetchData() -> [Messages] {
        var messages: [Messages]?
        
        //fetch the data from core data
        do {
            messages = try managedContext?.fetch(Messages.fetchRequest())
        } catch {
            print("fetching of messages failed")
        }
        return messages ?? []
    }
}
