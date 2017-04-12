//
//  ComicCell.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/4.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import UIKit

class ComicCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private var coverView: UIImageView?
    private var titleLable: UILabel?
    private var authouLabal: UILabel?
    private var descLabel: UILabel?
    private var updateLabel: UILabel?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.coverView = UIImageView(frame: CGRect(x: 10, y: 10, width: 105, height: 138))
        self.coverView?.layer.cornerRadius = 5
        self.coverView?.layer.masksToBounds = true
        
        self.titleLable = UILabel(frame: CGRect(x: (self.coverView?.frame.maxX)! + 10, y: 10, width: SCREEN_WIDTH - 135, height: 20))
        titleLable?.font = UIFont.systemFont(ofSize: 17)
        
        self.authouLabal = UILabel(frame: CGRect(x: (self.titleLable?.frame.origin.x)!, y: (self.titleLable?.frame.maxY)! + 10, width: SCREEN_WIDTH - 135, height: 14))
        self.authouLabal?.font = UIFont.systemFont(ofSize: 16)
        
        self.descLabel = UILabel(frame: CGRect(x: (self.titleLable?.frame.origin.x)!, y: (self.authouLabal?.frame.maxY)! + 10, width: SCREEN_WIDTH - 135, height: 50))
        self.descLabel?.numberOfLines = 0
        self.descLabel?.font = UIFont.systemFont(ofSize: 12)
        
        self.updateLabel = UILabel(frame: CGRect(x: (self.titleLable?.frame.origin.x)!, y: (self.descLabel?.frame.maxY)! + 10, width: SCREEN_WIDTH - 135, height: 20))
        self.updateLabel?.font = UIFont.systemFont(ofSize: 13)
        self.updateLabel?.textColor = UIColor.red
        
        self.contentView.addSubview(self.coverView!)
        self.contentView.addSubview(self.titleLable!)
        self.contentView.addSubview(self.authouLabal!)
        self.contentView.addSubview(self.descLabel!)
        self.contentView.addSubview(self.updateLabel!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createCell(tableView:UITableView, reuseIdentifier: String) -> ComicCell {
        var cell:ComicCell? = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? ComicCell
        if cell == nil {
            cell = ComicCell(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        }
        return cell!
    }

    func configCell(model:ComicModel) -> Void {
        if SDImageCache.shared().diskImageExists(withKey: model.comicId) {
            coverView?.image = SDImageCache.shared().imageFromDiskCache(forKey: model.comicId)
        }else {
            coverView?.sd_setImage(with: URL(string: model.images) as URL!, completed: { (image, error, cacheType, url) in
                SDImageCache.shared().store(image, forKey: model.comicId, toDisk: true)
            })
        }
        self.titleLable?.text = model.name
        self.authouLabal?.text = "作者：" + model.author
        self.descLabel?.text = "简介：" + model.introduction
        switch model.updateType {
        case "1", "3":
            self.updateLabel?.text = String(format: "%@  每周%@更新", model.updateInfo, model.updateValue)
        case "2":
            self.updateLabel?.text = String(format: "%@  每月%@日更新", model.updateInfo, model.updateValue)
        case "4":
            self.updateLabel?.text = String(format: "%@  更新%@", model.updateInfo, model.updateValue)
        case "5":
            self.updateLabel?.text = String(format: "%@  %@更新", model.updateInfo, model.updateValue)
        default:
            self.updateLabel?.text = model.updateInfo
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
