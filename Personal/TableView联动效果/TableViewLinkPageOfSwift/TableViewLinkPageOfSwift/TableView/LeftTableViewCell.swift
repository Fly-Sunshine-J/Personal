//
//  LeftTableViewCell.swift
//  TableViewLinkPageOfSwift
//
//  Created by vcyber on 17/4/10.
//  Copyright © 2017年 vcyber. All rights reserved.
//

import UIKit

class LeftTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private lazy var nameLabel = UILabel()
    private lazy var yellowView = UIView()
    
    var name:String? {
        set {
            nameLabel.text = newValue
        }
        get {
            return self.name;
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        contentView.backgroundColor = selected ? UIColor.white : UIColor(white: 0, alpha: 0.1)
        isHighlighted = selected
        nameLabel.isHighlighted = selected
        yellowView.isHidden = !selected
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() -> Void {
        nameLabel.frame = CGRect(x: 10, y: 10, width: 60, height: 40)
        nameLabel.numberOfLines = 0;
        nameLabel.font = UIFont.systemFont(ofSize: 15)
        nameLabel.textColor = UIColor(130, 130, 130)
        nameLabel.highlightedTextColor = UIColor(253, 212, 49)
        contentView.addSubview(nameLabel)
        
        yellowView.frame = CGRect(x: 0, y: 5, width: 5, height: 45)
        yellowView.backgroundColor = UIColor(253, 212, 49)
        contentView.addSubview(yellowView)
    }
    
    

}
