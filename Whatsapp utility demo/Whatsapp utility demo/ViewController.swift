//
//  ViewController.swift
//  Whatsapp utility demo
//
//  Created by MOHIT PAREEK on 05/11/20.
//  Copyright © 2020 MOHIT PAREEK. All rights reserved.
//

import UIKit
import TagListView

class ViewController: UIViewController {

    @IBOutlet weak var tagView: TagListView!
    @IBOutlet weak var enterTheNumberTextField: UITextField!
    @IBOutlet weak var enterTheMessageTextField: UITextView!
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var messages: [Messages] = []
    var tags: [String] = []
    let coreDataObj = CoreData()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        tagView.textFont = UIFont.systemFont(ofSize: 24)
        tagView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messages = coreDataObj.fetchData()
        self.addTagsOnTagView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tagView.removeAllTags()
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        
        openWhatsapp()

        
    }
    
    @IBAction func addNewCustomMessagePressed(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CustomSavedMessagesViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func openWhatsapp(){
        let urlWhats = "https://api.whatsapp.com/send?phone=+918259885915&abid=12354&text=Hello"
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
            }
        }
    }
    
    func addTagsOnTagView() {
        for title in messages {
            tagView.addTag(title.messageTitle!)
            
        }
        
    }
    
}

extension ViewController: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        for item in messages {
            if title == item.messageTitle! {
                enterTheMessageTextField.text = item.message
            }
        }
    }
}
