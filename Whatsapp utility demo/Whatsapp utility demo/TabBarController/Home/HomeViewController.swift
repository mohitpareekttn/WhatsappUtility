//
//  ViewController.swift
//  Whatsapp utility demo
//
//  Created by MOHIT PAREEK on 05/11/20.
//  Copyright © 2020 MOHIT PAREEK. All rights reserved.
//

import UIKit
import TagListView
import CoreData

class HomeViewController: UIViewController {

    @IBOutlet weak var tagView: TagListView!
    @IBOutlet weak var enterTheCodeTextField: UITextField!
    @IBOutlet weak var enterTheNumberTextField: UITextField!
    @IBOutlet weak var enterTheMessageTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var messages: [Messages] = []
    var tags: [String] = []
    let coreDataObj = CoreData()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagView.textFont = UIFont.systemFont(ofSize: 24)
        tagView.delegate = self
        setUpNavBar()
        setUpSendButton()
        setUpTextField()
        setUpMessageTextView()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messages = coreDataObj.fetchMessages()
        self.addTagsOnTagView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tagView.removeAllTags()
    }

    @IBAction func sendButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        openActionSheet()
        
    }
    

}

extension HomeViewController: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        for item in messages {
            if title == item.messageTitle! {
                enterTheMessageTextView.text = item.message
            }
        }
    }
}


extension HomeViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(textField: UITextField) {
        sendButton.isEnabled = !enterTheNumberTextField.text!.isEmpty && !enterTheCodeTextField.text!.isEmpty
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension HomeViewController: UITextViewDelegate {
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

extension HomeViewController {
    
    fileprivate func openWhatsapp(){
        //let phoneNumber =  "+919205156768"
        let urlWhats = "https://wa.me/" + "+" + enterTheNumberTextField.text! + "/?text=\(String(describing: enterTheMessageTextView.text))" //+918259885915/?text=hello"

        //let urlWhats = "https://api.whatsapp.com/send?phone=+918259885915&abid=12354&text=Hello"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install Whatsapp")
                }
                
                coreDataObj.createHistory(number: enterTheNumberTextField.text ?? "", message: enterTheMessageTextView.text)
            }
        }
    }
    
   fileprivate func sendMessage() {
        let sms = "sms:\(enterTheNumberTextField.text)&body=\(enterTheMessageTextView.text)."
                let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
        coreDataObj.createHistory(number: enterTheNumberTextField.text ?? "", message: enterTheMessageTextView.text)
    }
    
    fileprivate func addTagsOnTagView() {
        for title in messages {
            tagView.addTag(title.messageTitle!)
            
        }
        
    }
    
    fileprivate func openActionSheet() {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let sendOnWhatsapp = UIAlertAction(title: "Whatsapp", style: .default) { (handler) in
            self.openWhatsapp()
        }
        
        let sendTextMessage = UIAlertAction(title: "Message", style: .default) { (handler) in
            self.sendMessage()
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(sendOnWhatsapp)
        optionMenu.addAction(sendTextMessage)
        optionMenu.addAction(cancelAction)
        
        if let popoverPresentationController = optionMenu.popoverPresentationController {
            
            popoverPresentationController.sourceView = self.view
            // show the popover at the side of tapped view
            // popoverPresentationController.sourceRect = sender.bounds
            // for center in ipad
            popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                   // to remove the arrow for popover
            popoverPresentationController.permittedArrowDirections = []
        }
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    fileprivate func setUpNavBar() {
        navigationItem.title = "COMPOSE"
        navigationController?.navigationBar.barTintColor = Colors.appThemeColor
        navigationController?.navigationBar.tintColor = Colors.whiteColor
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Bold", size: 22)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    fileprivate func setUpSendButton() {
        sendButton.titleLabel?.font = UIFont(name: "SFProDisplay-Light", size: 18)
        sendButton.layer.cornerRadius = 25
        sendButton.layer.borderWidth = 1
        sendButton.layer.borderColor = Colors.whiteColor.cgColor
        sendButton.layer.backgroundColor = Colors.appThemeColor.cgColor
        sendButton.isEnabled = false
    }
    
    fileprivate func setUpMessageTextView() {
        enterTheMessageTextView.delegate = self
        enterTheMessageTextView.text = "Enter the message"
        enterTheMessageTextView.textColor = UIColor.lightGray
    }
    
    fileprivate func setUpTextField() {
        enterTheCodeTextField.delegate = self
        enterTheNumberTextField.delegate = self
        enterTheNumberTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        enterTheCodeTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
}
