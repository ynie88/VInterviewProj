//
//  Recipe.swift
//  SwiftyInterview
//
//  Created by Yuchen Nie on 9/8/16.
//  Copyright © 2016 Yuchen Nie. All rights reserved.
//

import Foundation
import UIKit

struct Recipe {
    let imageURL:String!
    let name:String!
    let description:String!
}

struct RecipeViewModel {
    let imageURL:URL!
    let name:NSAttributedString!
    let description:NSAttributedString!
    
    init(with model:Recipe){
        imageURL = URL(string: model.imageURL)
        
        let contentAttributes = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20.0),
            NSForegroundColorAttributeName:UIColor.blue
        ]
        
        name = NSMutableAttributedString(string: model.name, attributes: contentAttributes)
        
        let descriptionAttributes = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10.0),
            NSForegroundColorAttributeName:UIColor.lightGray
        ]
        
        description = NSMutableAttributedString(string: model.description, attributes: descriptionAttributes)
    }
}
