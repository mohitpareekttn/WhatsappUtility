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
    
    var history: [History]? {
        didSet {
            historyTableView.reloadData()
        }
    }
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nib = UINib(nibName: "HistoryTableViewCell", bundle: nil)
        historyTableView.register(nib, forCellReuseIdentifier: "HistoryCell")
        
        self.historyTableView.delegate = self
        self.historyTableView.dataSource = self
        
        navigationItem.title = "HISTORY"
        navigationController?.navigationBar.barTintColor = Colors.appThemeColor
        navigationController?.navigationBar.tintColor = Colors.whiteColor
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Bold", size: 22)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        history = CoreDataManager.sharedManager.fetchHistory()
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            //set the reference to the person object
            let messageToRemove = self.history![indexPath.row]
            
            //delete the object
            self.context.delete(messageToRemove)
            
            //save the data
            
            CoreDataManager.sharedManager.saveData()
            
            // re-fetch the data
            self.history = CoreDataManager.sharedManager.fetchHistory()
            self.historyTableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
        
    }
    
    
}
