//
//  ViewController.swift
//  Whatsapp utility demo
//
//  Created by MOHIT PAREEK on 05/11/20.
//  Copyright © 2020 MOHIT PAREEK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        
        openWhatsapp()
//        let phoneNumber =  "8259885915" // you need to change this number
//        let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
//        if UIApplication.shared.canOpenURL(appURL) {
//            if #available(iOS 10.0, *) {
//                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
//            }
//            else {
//                UIApplication.shared.openURL(appURL)
//            }
//        } else {
//            // WhatsApp is not installed
//        }
//
//        let urlWhats = "whatsapp://send?phone=+919789384445&abid=12354&text=Hello"
//        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
//            if let whatsappURL = URL(string: urlString) {
//                if UIApplication.shared.canOpenURL(whatsappURL) {
//                    UIApplication.shared.openURL(whatsappURL)
//                } else {
//                    print("Install Whatsapp")
//                }
//            }
//        }
        
    }
    
    
    func openWhatsapp(){
        let urlWhats = "whatsapp://send?phone=+918259885915&abid=12354&text=Hello"
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
    
}

