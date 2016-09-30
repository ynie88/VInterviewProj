//
//  FrameCell.swift
//  SwiftyInterview
//
//  Created by Yuchen Nie on 9/30/16.
//  Copyright © 2016 Yuchen Nie. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class FrameCell:UITableViewCell {
    static let identifier = "FrameCell"
    
    var titleLabel:UILabel?
    var detailLabel:UILabel?
    var recipeImage:UIImageView?
    
    func configure(with model: Recipe) {
        loadViews()
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
}

extension FrameCell {
    func loadViews() {
        if titleLabel == nil {
            titleLabel = UILabel()
            titleLabel?.frame = CGRect(x: 120, y: 10, width: self.frame.size.width-120, height: 100)
            self.contentView.addSubview(titleLabel!)
        }
        
        if detailLabel == nil {
            detailLabel = UILabel()
            detailLabel?.frame = CGRect(x: 120, y: (titleLabel?.frame.origin.y)! + (titleLabel?.frame.size.height)! + 10, width: (titleLabel?.frame.width)!, height: 100)
            self.contentView.addSubview(detailLabel!)
        }
        
        if recipeImage == nil {
            recipeImage = UIImageView()
            recipeImage?.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
            self.contentView.addSubview(recipeImage!)
        }
    }
}
