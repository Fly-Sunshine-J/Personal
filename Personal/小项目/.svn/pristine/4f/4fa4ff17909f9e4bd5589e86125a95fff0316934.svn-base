//
//  CategoryCell.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/7.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    var coverView:UIImageView?
    var nameLabel:UILabel?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.coverView = UIImageView(frame: CGRect(x: 0, y: 0, width: (SCREEN_WIDTH - 60) / 3, height: (SCREEN_WIDTH - 60) / 3))
        self.coverView?.layer.cornerRadius = 10
        self.coverView?.layer.masksToBounds = true
        self.contentView.addSubview(self.coverView!)
        
        self.nameLabel = UILabel(frame: CGRect(x: 0, y: (self.coverView?.frame.maxY)!, width: (SCREEN_WIDTH - 60) / 3, height: 20))
        self.nameLabel?.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(self.nameLabel!)
    }
    
    func configCell(model:CategoryModel) -> Void {
        self.coverView?.sd_setImage(with: URL(string: model.images) as URL!, placeholderImage: UIImage(named: "default_image")!)
        self.nameLabel?.text = model.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
