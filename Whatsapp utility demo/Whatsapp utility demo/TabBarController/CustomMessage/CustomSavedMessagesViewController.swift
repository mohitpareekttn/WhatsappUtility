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
    @IBOutlet weak var newMessageTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var customMessageTableView: UITableView!
    
    var messages: [Messages]?
    let coreDataObject = CoreData()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customMessageTableView.dataSource = self
        self.customMessageTableView.delegate = self
        self.newMessageTextView.delegate = self
        newMessageTextView.text = "Enter the message"
        newMessageTextView.textColor = UIColor.lightGray
        setUpNavigationBar()
        setUpSaveButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messages = coreDataObject.fetchMessages()
        self.messages?.reverse()
        customMessageTableView.reloadData()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        coreDataObject.createMessage(title: titleOfMessageTextField.text ?? "nil", message: newMessageTextView.text)
        DispatchQueue.main.async {
            self.messages = self.coreDataObject.fetchMessages()
            self.messages?.reverse()
            self.customMessageTableView.reloadData()
        }
    }
    
    fileprivate func setUpSaveButton() {
        saveButton.backgroundColor = Colors.appThemeColor
        saveButton.titleLabel?.font = UIFont(name: "SFProDisplay-Light", size: 18)
        saveButton.layer.cornerRadius = 25
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = Colors.whiteColor.cgColor
    }
    
    fileprivate func setUpNavigationBar() {
        navigationItem.title = "CUSTOM MESSAGE"
        navigationController?.navigationBar.barTintColor = Colors.appThemeColor
        navigationController?.navigationBar.tintColor = Colors.whiteColor
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Bold", size: 22)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
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
}

extension CustomSavedMessagesViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter the message"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
