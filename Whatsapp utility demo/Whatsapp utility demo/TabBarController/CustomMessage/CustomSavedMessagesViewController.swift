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
    @IBOutlet weak var updateAndDeleteView: UIStackView!
    @IBOutlet weak var updateButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    var messages: [Messages]?
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    var counter = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customMessageTableView.dataSource = self
        self.customMessageTableView.delegate = self
        self.newMessageTextView.delegate = self
        newMessageTextView.text = "Enter the message"
        newMessageTextView.textColor = UIColor.lightGray
        setUpNavigationBar()
        setUpSaveButton()
        updateAndDeleteView.isHidden = true
        setUpUpdateButton()
        setUpDeleteButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messages = CoreDataManager.sharedManager.fetchMessages()
        self.messages?.reverse()
        customMessageTableView.reloadData()
        print(messages?.count)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        
        CoreDataManager.sharedManager.createMessage(title: titleOfMessageTextField.text ?? "nil", message: newMessageTextView.text)
        DispatchQueue.main.async {
            self.messages = CoreDataManager.sharedManager.fetchMessages()
            self.messages?.reverse()
            self.customMessageTableView.reloadData()
        }
        titleOfMessageTextField.text = ""
        newMessageTextView.text = "Enter the message"
        newMessageTextView.textColor = UIColor.lightGray
    }
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        //let message = Messages(context: CoreDataManager.managedContext)
        
        CoreDataManager.sharedManager.updateMessage(title: titleOfMessageTextField.text ?? "", message: newMessageTextView.text, counter: Int64(counter))
        titleOfMessageTextField.text = ""
        newMessageTextView.text = "Enter the message"
        newMessageTextView.textColor = UIColor.lightGray
        updateAndDeleteView.isHidden = true
        DispatchQueue.main.async {
            self.messages = CoreDataManager.sharedManager.fetchMessages()
            self.messages?.reverse()
            self.customMessageTableView.reloadData()
        }
        
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        titleOfMessageTextField.text = ""
        newMessageTextView.text = "Enter the message"
        newMessageTextView.textColor = UIColor.lightGray
        updateAndDeleteView.isHidden = true
        DispatchQueue.main.async {
            self.messages = CoreDataManager.sharedManager.fetchMessages()
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
    
    fileprivate func setUpUpdateButton() {
        updateButton.backgroundColor = Colors.appThemeColor
        updateButton.titleLabel?.font = UIFont(name: "SFProDisplay-Light", size: 18)
        updateButton.titleLabel?.textColor = Colors.whiteColor
        updateButton.layer.cornerRadius = 25
        updateButton.layer.borderWidth = 1
        updateButton.layer.borderColor = Colors.whiteColor.cgColor
    }
    
    fileprivate func setUpDeleteButton() {
        deleteButton.backgroundColor = Colors.deleteButtonColor
        deleteButton.titleLabel?.font = UIFont(name: "SFProDisplay-Light", size: 18)
        deleteButton.titleLabel?.textColor = .black
        deleteButton.layer.cornerRadius = 25
        deleteButton.layer.borderWidth = 1
        deleteButton.layer.borderColor = UIColor.black.cgColor
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
            self.context.delete(messageToRemove)
            
            //save the data
            
            CoreDataManager.sharedManager.saveData()
            
            // re-fetch the data
            self.messages = CoreDataManager.sharedManager.fetchMessages()
            self.customMessageTableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let message = messages![indexPath.row]
        titleOfMessageTextField.text = message.messageTitle
        newMessageTextView.text = message.message
        counter = (Int(message.counter))
        updateAndDeleteView.isHidden = false
        //set the reference to the person object
        let messageToRemove = self.messages![indexPath.row]
        
        //delete the object
        self.context.delete(messageToRemove)
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
