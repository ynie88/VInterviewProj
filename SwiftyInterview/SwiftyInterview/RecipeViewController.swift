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
        tableView.registerClass(RecipeCell.self, forCellReuseIdentifier: RecipeCell.reuseID)
        tableView.separatorColor = .clearColor()
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
    }
    
    
}

extension RecipeViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
}

extension RecipeViewController {
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(RecipeCell.reuseID, forIndexPath: indexPath) as! RecipeCell
        
        let recipe = recipes[indexPath.row]
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