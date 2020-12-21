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

    @IBOutlet weak var segmentedControl: UISegmentedControl!
   // @IBOutlet weak var tagView: TagListView!
    @IBOutlet weak var enterTheCodeTextField: UITextField!
    @IBOutlet weak var enterTheNumberTextField: UITextField!
    @IBOutlet weak var enterTheMessageTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    var messages: [Messages] = []
    var tags: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tagView.textFont = UIFont.systemFont(ofSize: 24)
//        tagView.delegate = self
        setUpNavBar()
        setUpSendButton()
        setUpTextField()
        setUpMessageTextView()
        segmentedControl.backgroundColor = Colors.whiteColor
        segmentedControl.selectedSegmentTintColor = Colors.appThemeColor
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("<<<<<<<<<viewwillappear")
        messages = CoreDataManager.sharedManager.fetchMessages()
        //self.addTagsOnTagView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //tagView.removeAllTags()
    }

    
    @IBAction func segmentPressed(_ sender: UISegmentedControl) {
                
        switch sender.selectedSegmentIndex {
        case 0:
            moveToComposeVC()
        case 1:
            moveToHistoryVC()
        case 2:
            moveToFavourites()
            
        case 3:
            moveToSettingsVC()
        default:
            break
        }
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        openActionSheet()
        
    }
    

}

//extension HomeViewController: TagListViewDelegate {
//    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
//        for item in messages {
//            if title == item.messageTitle! {
//                enterTheMessageTextView.text = item.message
//            }
//        }
//        enterTheMessageTextView.textColor = .black
//        enterTheMessageTextView.becomeFirstResponder()
//    }
//}


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
    
    fileprivate func moveToComposeVC() {
        if self.children.count > 0{
            let viewControllers:[UIViewController] = self.children
            for viewContoller in viewControllers{
                viewContoller.willMove(toParent: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParent()
            }
        }
    }
    
    fileprivate func moveToHistoryVC() {
        let historyVC = HistoryViewController.instantiate(fromAppStoryboard: .WUHistoryStoryBoard)
        addChild(historyVC!)
        view.addSubview(historyVC!.view)
        historyVC!.didMove(toParent: self)
        historyVC!.view.translatesAutoresizingMaskIntoConstraints = false
        historyVC!.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 0).isActive = true
        historyVC!.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        historyVC!.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        historyVC!.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
    
    fileprivate func moveToSettingsVC() {
        let settingsVC = FeaturedViewController.instantiate(fromAppStoryboard: .FeaturedStoryBoard)
        
        addChild(settingsVC!)
        view.addSubview(settingsVC!.view)
        settingsVC!.didMove(toParent: self)
        settingsVC!.view.translatesAutoresizingMaskIntoConstraints = false
        settingsVC!.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 0).isActive = true
        settingsVC!.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        settingsVC!.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        settingsVC!.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
    
    fileprivate func moveToFavourites() {
        let favouritesVC = CustomSavedMessagesViewController.instantiate(fromAppStoryboard: .CustomMessageStoryBoard)
        addChild(favouritesVC!)
        view.addSubview(favouritesVC!.view)
        favouritesVC!.didMove(toParent: self)
        favouritesVC!.view.translatesAutoresizingMaskIntoConstraints = false
        favouritesVC!.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 0).isActive = true
        favouritesVC!.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        favouritesVC!.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        favouritesVC!.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
    
    fileprivate func openWhatsapp(){
        //let phoneNumber =  "+919205156768"
        let urlWhats = "https://wa.me/" + "+" + enterTheCodeTextField.text! + enterTheNumberTextField.text! + "/?text=\(String(describing: enterTheMessageTextView.text!))" //+918259885915/?text=hello"

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
                
                CoreDataManager.sharedManager.createHistory(number: enterTheNumberTextField.text ?? "", message: enterTheMessageTextView.text)
            }
        }
    }
    
   fileprivate func sendMessage() {
        let sms = "sms:+" + enterTheCodeTextField.text! + enterTheNumberTextField.text! + "&body=" + enterTheMessageTextView.text!
        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
        CoreDataManager.sharedManager.createHistory(number: enterTheNumberTextField.text ?? "", message: enterTheMessageTextView.text)
    }
    
//    fileprivate func addTagsOnTagView() {
//        for title in messages {
//            tagView.addTag(title.messageTitle!)
//
//        }
//
//    }
    
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
        navigationController?.navigationBar.barTintColor = Colors.whiteColor
        navigationController?.navigationBar.tintColor = Colors.whiteColor
//        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Bold", size: 22)!]
//        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    fileprivate func setUpSendButton() {
        sendButton.titleLabel?.font = UIFont(name: "SFProDisplay-Light", size: 18)
        sendButton.layer.cornerRadius = 10
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
