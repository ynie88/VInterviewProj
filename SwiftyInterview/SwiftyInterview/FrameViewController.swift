//
//  FrameViewController.swift
//  SwiftyInterview
//
//  Created by Yuchen Nie on 9/30/16.
//  Copyright © 2016 Yuchen Nie. All rights reserved.
//

import Foundation
import UIKit

let imageUrl = "http://lorempixel.com/400/400/"

class FrameViewController:UITableViewController {
    var recipes = [Recipe]()
    
    override func viewDidLoad() {
        registerCell()
        loadCannedData()
        tableView.allowsSelection = false
    }
    
    func registerCell() {
        tableView.register(FrameCell.self, forCellReuseIdentifier: FrameCell.identifier)
    }
}

extension FrameViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

extension FrameViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FrameCell.identifier, for: indexPath) as! FrameCell
        
        let recipe = recipes[(indexPath as NSIndexPath).row]
        cell.configure(with: recipe)
        return cell
    }
}

extension FrameViewController {
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

struct Constants{
    static let LongText = "Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text"
    static let ShortText = "Short Text"
    static let MediumText = "Medium Text Medium Text Medium Text Medium Text Medium Text Medium Text Medium Text Medium Text Medium Text Medium Text Medium Text Medium Text Medium Text Medium Text Medium"
}
