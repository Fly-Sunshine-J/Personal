//
//  PictureCell.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/8.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import UIKit

class PictureCell: UICollectionViewCell {
    
    var picView:UIImageView?
    var countLable:UILabel?
    private var album:UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        picView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH / 2 - 0.5, height: SCREEN_WIDTH / 2 - 0.5))
        contentView.addSubview(picView!)
        countLable = UILabel(frame: CGRect(x: 0, y: (picView?.frame.maxY)! - 20, width: SCREEN_WIDTH / 2 - 0.5, height: 20))
        countLable?.backgroundColor = UIColor(white: 0.7, alpha: 0.8)
        countLable?.textAlignment = .center
        countLable?.font = UIFont.systemFont(ofSize: 13)
        contentView.addSubview(countLable!)
         album = UIImageView(frame: CGRect(x: (picView?.frame.maxX)! / 2 - 30, y: (countLable?.frame.origin.y)!, width: 20, height: 20))
        album?.image = UIImage(named: "album")
        contentView.addSubview(album!)
    }
    
    func configCell(model: PictureModel) -> Void {
        if model.qhimg_thumb_url == nil {
            picView?.sd_setImage(with: URL(string: model.icon!["url"] as! String), placeholderImage: UIImage(named: "default_image"))
            countLable?.text = String(format: "%@", model.name!)
            album?.isHidden = true
            
        }else {
            picView?.sd_setImage(with: URL(string: model.qhimg_thumb_url!), placeholderImage: UIImage(named: "default_image"))
            countLable?.text = String(format: "【%@】", model.total_count!)
            album?.isHidden = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
