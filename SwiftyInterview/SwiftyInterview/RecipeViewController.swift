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
        testFile()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        uploadFiles()
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            S3Helper.sharedInstance.upload()
        } else if indexPath.row == 5 {
            S3Helper.sharedInstance.download()
        }
        else {
            S3Helper.sharedInstance.writeToFile(text: "Hello another world\n")
        }
    }
}

extension RecipeViewController {
    func loadCannedData() {
        let model1 = Recipe(imageURL: imageUrl, name: "Swift", description: Constants.LongText)
        let model2 = Recipe(imageURL: imageUrl, name: "Objective-C", description: Constants.MediumText)
        let model3 = Recipe(imageURL: imageUrl, name: "Java", description: "What Everyone uses")
        let model4 = Recipe(imageURL: imageUrl, name: "Javascript", description: "A New Library every 15 seconds")
        let model5 = Recipe(imageURL: imageUrl, name: "Javascript", description: "A New Library every 15 seconds")
        let model6 = Recipe(imageURL: imageUrl, name: "Javascript", description: "A New Library every 15 seconds")
        recipes.append(model1)
        recipes.append(model2)
        recipes.append(model3)
        recipes.append(model4)
        recipes.append(model5)
        recipes.append(model6)
        
    }
}

extension RecipeViewController {
    func testFile() {
        S3Helper.sharedInstance.writeToFile(text: "hello world\n")
    }
    
    func uploadFiles() {
        //S3Helper.sharedInstance.upload()
    }
}
