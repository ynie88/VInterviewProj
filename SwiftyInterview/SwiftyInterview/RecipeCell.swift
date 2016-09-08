//
//  RecipeCell.swift
//  SwiftyInterview
//
//  Created by Yuchen Nie on 9/8/16.
//  Copyright © 2016 Yuchen Nie. All rights reserved.
//

import Foundation
import SnapKit
import Kingfisher

class RecipeCell:UITableViewCell {
    static let reuseID = "RecipeCellReuseID"
    
    private lazy var imageContainer:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(view)
        return view
    }()
    
    private lazy var leadImage:UIImageView = {
        let imageView = UIImageView()
        self.imageContainer.addSubview(imageView)
        return imageView
    }()
    
    private lazy var primaryLabel:UILabel = {
        let label = UILabel()
        self.contentView.addSubview(label)
        return label
    }()
    
    private lazy var secondaryLabel:UILabel = {
        let label = UILabel()
        self.contentView.addSubview(label)
        return label
    }()
    
    func configure(with model:Recipe){
        let viewModel = RecipeViewModel(with: model)
        primaryLabel.attributedText = viewModel.name
        secondaryLabel.attributedText = viewModel.description
        
        leadImage.kf_setImageWithURL(viewModel.imageURL)
        
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        self.contentView
        imageContainer.snp_updateConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.centerY.equalTo(self.contentView)
            make.width.equalTo(80)
            make.height.equalTo(imageContainer.snp_width)
        }
        
        leadImage.snp_updateConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(imageContainer)
        }
        
        primaryLabel.snp_updateConstraints { (make) in
            make.top.equalTo(self.contentView).offset(50)
            make.trailing.equalTo(self.contentView).offset(10)
            make.leading.equalTo(self.imageContainer.snp_trailing).offset(10)
        }
        
        secondaryLabel.snp_updateConstraints { (make) in
            make.leading.trailing.equalTo(primaryLabel)
            make.top.equalTo(primaryLabel.snp_bottom).offset(5).priority(999)
            make.bottom.equalTo(self.contentView).inset(50)
        }
        
        super.updateConstraints()
    }
}