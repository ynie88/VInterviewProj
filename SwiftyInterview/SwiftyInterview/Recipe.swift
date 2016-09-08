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
    let imageURL:NSURL!
    let name:NSAttributedString!
    let description:NSAttributedString!
    
    init(with model:Recipe){
        imageURL = NSURL(string: model.imageURL)
        
        let contentAttributes = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(20.0),
            NSForegroundColorAttributeName:UIColor.blueColor()
        ]
        
        name = NSMutableAttributedString(string: model.name, attributes: contentAttributes)
        
        let descriptionAttributes = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(10.0),
            NSForegroundColorAttributeName:UIColor.lightGrayColor()
        ]
        
        description = NSMutableAttributedString(string: model.description, attributes: descriptionAttributes)
    }
}