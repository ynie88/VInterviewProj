//
//  BlankCell.swift
//  SwiftyInterview
//
//  Created by Yuchen Nie on 1/31/17.
//  Copyright © 2017 Yuchen Nie. All rights reserved.
//

import Foundation
import SnapKit
import Kingfisher

class BlankCell:UITableViewCell {
    static let reuseID = "BlankCellReuseID"
    
    var titleLabel:UILabel?
    var detailLabel:UILabel?
    var recipeImage:UIImageView?
    
    func configure(with model: Recipe) {
        let viewModel = RecipeViewModel(with: model)
        titleLabel?.attributedText = viewModel.name
        detailLabel?.attributedText = viewModel.description
        KingfisherManager.shared.retrieveImage(with: viewModel.imageURL, options: nil, progressBlock: nil) { [weak self] (image, error, cacheType, url) in
            guard let weakSelf = self else {fatalError("self is nil")}
            if let error = error {
                print("error loading image: \(error)")
                return
            }
            if let image = image {
                weakSelf.recipeImage?.image = image
            }
        }
    }
    
    override func updateConstraints() {
        //Add in constraints here
        super.updateConstraints()
    }
}
