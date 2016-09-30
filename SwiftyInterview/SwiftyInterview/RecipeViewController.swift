//
//  RecipeViewController.swift
//  SwiftyInterview
//
//  Created by Yuchen Nie on 9/8/16.
//  Copyright © 2016 Yuchen Nie. All rights reserved.
//

import Foundation
import UIKit

protocol RecipeViewControllerInput {
}

protocol RecipeViewControllerOutput {
}

class RecipeViewController:UITableViewController, RecipeViewControllerInput {
    var output:RecipeViewControllerOutput?
    var recipes = [Recipe]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableview()
        loadCannedData()
    }
    
    func configureTableview() {
        tableView.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.reuseID)
        tableView.separatorColor = UIColor.clear
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
    }
    
    
}

extension RecipeViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
}

extension RecipeViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.reuseID, for: indexPath) as! RecipeCell
        
        let recipe = recipes[(indexPath as NSIndexPath).row]
        cell.configure(with:recipe)
        
        return cell
    }
}

extension RecipeViewController {
    func loadCannedData() {
        let model1 = Recipe(imageURL: "http://loremflickr.com/400/400?random=4", name: "Swift", description: "A New Language from Apple")
        let model2 = Recipe(imageURL: "http://loremflickr.com/400/400?random=4", name: "Objective-C", description: "The Original from Apple")
        let model3 = Recipe(imageURL: "http://loremflickr.com/400/400?random=4", name: "Java", description: "What Everyone uses")
        let model4 = Recipe(imageURL: "http://loremflickr.com/400/400?random=4", name: "Javascript", description: "A New Library every 15 seconds")
        
        recipes.append(model1)
        recipes.append(model2)
        recipes.append(model3)
        recipes.append(model4)
        
    }
}
