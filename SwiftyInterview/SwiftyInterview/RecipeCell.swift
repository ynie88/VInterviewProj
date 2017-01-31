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
    
    fileprivate lazy var imageContainer:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        self.contentView.addSubview(view)
        return view
    }()
    
    fileprivate lazy var leadImage:UIImageView = {
        let imageView = UIImageView()
        self.imageContainer.addSubview(imageView)
        return imageView
    }()
    
    fileprivate lazy var primaryLabel:UILabel = {
        let label = UILabel()
        self.contentView.addSubview(label)
        return label
    }()
    
    fileprivate lazy var secondaryLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        self.contentView.addSubview(label)
        return label
    }()
    
    func configure(with model:Recipe){
        let viewModel = RecipeViewModel(with: model)
        primaryLabel.attributedText = viewModel.name
        secondaryLabel.attributedText = viewModel.description
        KingfisherManager.shared.retrieveImage(with: viewModel.imageURL, options: nil, progressBlock: nil) { [weak self] (image, error, cacheType, url) in
            if let error = error {
                print("image could not be loaded: \(error)")
                return
            }
            guard let weakSelf = self else {fatalError("self is nil")}
            weakSelf.leadImage.image = image
        }
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        imageContainer.snp.updateConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.centerY.equalTo(self.contentView)
            make.width.equalTo(80)
            make.height.equalTo(imageContainer.snp.width)
        }
        
        leadImage.snp.updateConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(imageContainer)
        }
        
        primaryLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.contentView).offset(50)
            make.trailing.equalTo(self.contentView).offset(10)
            make.leading.equalTo(self.imageContainer.snp.trailing).offset(10)
        }
        
        secondaryLabel.snp.updateConstraints { (make) in
            make.leading.equalTo(primaryLabel)
            make.trailing.equalTo(self.contentView).inset(15)
            make.top.equalTo(primaryLabel.snp.bottom).offset(5).priority(999)
            make.bottom.equalTo(self.contentView).inset(50)
        }
        
        super.updateConstraints()
    }
}
