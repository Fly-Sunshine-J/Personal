//
//  TableViewHeaderView.swift
//  TableViewLinkPageOfSwift
//
//  Created by vcyber on 17/4/10.
//  Copyright © 2017年 vcyber. All rights reserved.
//

import UIKit

class TableViewHeaderView: UIView {

    lazy var nameLabel = UILabel();
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(240, 240, 240, 0.8)
        nameLabel.frame = CGRect(x: 15, y: 0, width: 200, height: 20)
        nameLabel.font = UIFont.systemFont(ofSize: 13)
        addSubview(nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
