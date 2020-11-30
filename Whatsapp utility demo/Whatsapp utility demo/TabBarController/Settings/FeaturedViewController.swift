//
//  FeaturedViewController.swift
//  Whatsapp utility demo
//
//  Created by MOHIT PAREEK on 20/11/20.
//  Copyright © 2020 MOHIT PAREEK. All rights reserved.
//

import UIKit

class FeaturedViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var items = ["Contact US", "Rate Us", "Remove Ads", "About Us"]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        navigationItem.title = "COMPOSE"
        navigationController?.navigationBar.barTintColor = UIColor(red: 67/255, green: 242/255, blue: 132/255, alpha: 1.0)
        navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    

}

extension FeaturedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let featuredCell = tableView.dequeueReusableCell(withIdentifier: "FeaturedCell")
        featuredCell?.textLabel?.text = items[indexPath.row]
        return featuredCell!
        
    }
    
    
}
