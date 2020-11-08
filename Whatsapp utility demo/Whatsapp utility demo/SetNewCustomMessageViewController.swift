//
//  SetNewCustomMessageViewController.swift
//  Whatsapp utility demo
//
//  Created by MOHIT PAREEK on 08/11/20.
//  Copyright © 2020 MOHIT PAREEK. All rights reserved.
//

import UIKit

class SetNewCustomMessageViewController: UIViewController {

    @IBOutlet weak var titleOfMessageTextField: UITextField!
    @IBOutlet weak var newMessageTextField: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    let coreDataObj = CoreData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        coreDataObj.createData(title: titleOfMessageTextField.text ?? "nil", message: newMessageTextField.text)
//        coreDataObj.saveData()
        navigationController?.popViewController(animated: true)
    }
    
    
}
