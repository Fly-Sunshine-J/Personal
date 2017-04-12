//
//  RightTableViewCell.swift
//  TableViewLinkPageOfSwift
//
//  Created by vcyber on 17/4/10.
//  Copyright © 2017年 vcyber. All rights reserved.
//

import UIKit

class RightTableViewCell: UITableViewCell {

    private lazy var nameLabel = UILabel()
    private lazy var imageV = UIImageView()
    private lazy var priceLabel = UILabel();
    
    var foodModel: FoodModel {
        get {
            return self.foodModel
        }
        set {
            guard let minPrice = newValue.minPrice,
                  let picture = newValue.picture,
                  let name = newValue.name
            else { return }
            nameLabel.text = name
            priceLabel.text = "￥\(minPrice)"
            
            guard let url = URL(string: picture) else { return }
            imageV.kf.setImage(with: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI();
    }
    
    private func setUI() -> Void {
        imageV.frame = CGRect(x: 15, y: 15, width: 50, height: 50)
        contentView.addSubview(imageV);
        
        nameLabel.frame = CGRect(x: 80, y: 10, width: 200, height: 30)
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(nameLabel)
        
        priceLabel.frame = CGRect(x: 80, y: 45, width: 200, height: 30)
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        priceLabel.textColor = UIColor.red
        contentView.addSubview(priceLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
