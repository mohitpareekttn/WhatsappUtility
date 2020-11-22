//
//  HistoryViewController.swift
//  Whatsapp utility demo
//
//  Created by MOHIT PAREEK on 19/11/20.
//  Copyright © 2020 MOHIT PAREEK. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    
    let coreDataObject = CoreData()
    var history: [History]? {
        didSet {
            historyTableView.reloadData()
        }
    }
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.historyTableView.delegate = self
        self.historyTableView.dataSource = self
        
        let nib = UINib(nibName: "HistoryTableViewCell", bundle: nil)
        historyTableView.register(nib, forCellReuseIdentifier: "HistoryCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        history = coreDataObject.fetchHistory()
        historyTableView.reloadData()
    }

}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as! HistoryTableViewCell
        let history = self.history?[indexPath.row]
        
        cell.phoneNumber.text = history?.number
        cell.message.text = history?.message
        
        return cell
        
    }
    
    
}
