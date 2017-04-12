//
//  ComicItemView.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/9.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import UIKit

@objc public protocol ComicItemViewDelegate: NSObjectProtocol{
    @objc optional func clickItem(tag:NSInteger) -> Void
}

class ComicItemView: UIScrollView {
    
    weak open var itemViewDelegate: ComicItemViewDelegate?
    

    init(frame: CGRect, items: NSInteger) {
        super.init(frame: frame)
        self.showsHorizontalScrollIndicator = false
        self.contentSize = CGSize(width: SCREEN_WIDTH, height: CGFloat(items / 4 * 45))
        let xSpace: CGFloat = (SCREEN_WIDTH - 70 * 4) / 5
        for i in 0..<items {
            let btn: UIButton = UIButton(frame: CGRect(x: xSpace + (70 + xSpace) * CGFloat(i % 4), y: (5 + 40.0) * CGFloat(i / 4), width: 70.0, height: 40.0))
            btn.layer.cornerRadius = 5
            btn.layer.masksToBounds = true
            btn.tag = 1000 + i
            btn.setTitle(String(format: "第%d话", i + 1), for: .normal)
            btn.backgroundColor = UIColor(white: 0.2, alpha: 0.2)
            btn.addTarget(self, action: #selector(click(btn:)), for: .touchUpInside)
            self.addSubview(btn)
        }
    }
    
    func click(btn: UIButton) -> Void {
        itemViewDelegate?.clickItem?(tag: btn.tag - 1000)
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
