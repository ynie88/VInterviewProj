//
//  BlankViewController.swift
//  SwiftyInterview
//
//  Created by Yuchen Nie on 1/31/17.
//  Copyright © 2017 Yuchen Nie. All rights reserved.
//

import Foundation
import UIKit

class BlankViewController:UITableViewController {
    var recipes = [Recipe]()
    
    override func viewDidLoad() {
        configureTableview()
        loadCannedData()
        tableView.allowsSelection = false
    }
    func configureTableview() {
        tableView.register(BlankCell.self, forCellReuseIdentifier: BlankCell.reuseID)
        tableView.separatorColor = UIColor.clear
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
    }
}

extension BlankViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
}

extension BlankViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BlankCell.reuseID, for: indexPath) as! BlankCell
        
        let recipe = recipes[(indexPath as NSIndexPath).row]
        cell.configure(with: recipe)
        return cell
    }
}

extension BlankViewController {
    func loadCannedData() {
        let model1 = Recipe(imageURL: imageUrl, name: "Swift", description: Constants.LongText)
        let model2 = Recipe(imageURL: imageUrl, name: "Objective-C", description: Constants.MediumText)
        let model3 = Recipe(imageURL: imageUrl, name: "Java", description: Constants.ShortText)
        let model4 = Recipe(imageURL: imageUrl, name: "Javascript", description: "A New Library every 15 seconds")
        
        recipes.append(model1)
        recipes.append(model2)
        recipes.append(model3)
        recipes.append(model4)
        
    }
}
