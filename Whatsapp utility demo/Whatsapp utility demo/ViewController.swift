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
        
        
        let phoneNumber =  "8259885915" // you need to change this number
        let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL)
            }
        } else {
            // WhatsApp is not installed
        }
        
    }
    
}

