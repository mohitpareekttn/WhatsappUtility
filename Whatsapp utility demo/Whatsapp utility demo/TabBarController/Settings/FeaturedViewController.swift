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
        setUpNavBar()
        
    }
    
    fileprivate func setUpNavBar() {
        navigationItem.title = "SETTINGS"
        navigationController?.navigationBar.barTintColor = Colors.appThemeColor
        navigationController?.navigationBar.tintColor = Colors.whiteColor
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Bold", size: 22)!]
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
