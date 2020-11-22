//
//  CustomSavedMessagesViewController.swift
//  Whatsapp utility demo
//
//  Created by MOHIT PAREEK on 08/11/20.
//  Copyright © 2020 MOHIT PAREEK. All rights reserved.
//

import UIKit

class CustomSavedMessagesViewController: UIViewController {

    @IBOutlet weak var titleOfMessageTextField: UITextField!
    @IBOutlet weak var newMessageTextField: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var customMessageTableView: UITableView!
    
    var messages: [Messages]?
    let coreDataObject = CoreData()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customMessageTableView.dataSource = self
        self.customMessageTableView.delegate = self
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messages = coreDataObject.fetchMessages()
        self.messages?.reverse()
        customMessageTableView.reloadData()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        coreDataObject.createMessage(title: titleOfMessageTextField.text ?? "nil", message: newMessageTextField.text)
        DispatchQueue.main.async {
            self.messages = self.coreDataObject.fetchMessages()
            self.messages?.reverse()
            self.customMessageTableView.reloadData()
        }
    }
    
}

extension CustomSavedMessagesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageCell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        let message = self.messages?[indexPath.row]
        messageCell.textLabel?.text = message?.messageTitle
        
        return messageCell
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            //set the reference to the person object
            let messageToRemove = self.messages![indexPath.row]
            
            //delete the object
            self.context?.delete(messageToRemove)
            
            //save the data
            
            self.coreDataObject.saveData()
            
            // re-fetch the data
            self.messages = self.coreDataObject.fetchMessages()
            self.customMessageTableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "SetNewCustomMessageViewController")
            navigationController?.pushViewController(vc, animated: true)
            
            
        }
    }
}
