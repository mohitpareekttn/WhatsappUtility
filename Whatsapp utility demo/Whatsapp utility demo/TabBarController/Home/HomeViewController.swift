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
        // Do any additional setup after loading the view.
        
        tagView.textFont = UIFont.systemFont(ofSize: 24)
        tagView.delegate = self
        sendButton.titleLabel?.font = UIFont(name: "SFProDisplay-Light", size: 18)
        sendButton.layer.cornerRadius = 25
        sendButton.layer.borderWidth = 1
        sendButton.layer.borderColor = UIColor.white.cgColor
        sendButton.layer.backgroundColor = UIColor(red: 67/255, green: 242/255, blue: 132/255, alpha: 1.0).cgColor
        navigationItem.title = "COMPOSE"
        navigationController?.navigationBar.barTintColor = UIColor(red: 67/255, green: 242/255, blue: 132/255, alpha: 1.0)
        navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        enterTheCodeTextField.delegate = self
        //enterTheNumberTextField.delegate = self
        if ((enterTheCodeTextField.text?.isEmpty) != nil) {
            sendButton.isUserInteractionEnabled = false
        }
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

    @IBAction func buttonPressed(_ sender: UIButton) {
        //self.view.endEditing(true)
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
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    
    
    
    func openWhatsapp(){
        //let phoneNumber =  "+919205156768"
        let urlWhats = "https://wa.me/" + enterTheNumberTextField.text! + "/?text=hello" //+918259885915/?text=hello"

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
    
    func sendMessage() {
        let sms = "sms:\(enterTheNumberTextField.text)&body=\(enterTheMessageTextView.text)."
                let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
        coreDataObj.createHistory(number: enterTheNumberTextField.text ?? "", message: enterTheMessageTextView.text)
    }
    
    func addTagsOnTagView() {
        for title in messages {
            tagView.addTag(title.messageTitle!)
            
        }
        
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let code = (enterTheCodeTextField.text! as NSString).replacingCharacters(in: range, with: string)
        //let number = (enterTheNumberTextField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if !code.isEmpty {
            sendButton.isUserInteractionEnabled = true
        } else {
            sendButton.isUserInteractionEnabled = false
        }
         return true

    }
}
