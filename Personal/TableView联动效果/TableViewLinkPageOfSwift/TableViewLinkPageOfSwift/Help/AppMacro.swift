//
//  AppMacro.swift
//  TableViewLinkPageOfSwift
//
//  Created by vcyber on 17/4/10.
//  Copyright © 2017年 vcyber. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let kLeftTableViewCell = "LeftTableViewCell"
let kRightTableViewCell = "LeftTableViewCell"
let kLeftCollectionViewCell = "LeftCollectionViewCell"
let kRightCollectionViewCell = "RightCollectionViewCell"

//func rgbColor(_ red:CGFloat, _ green:CGFloat, _ blue:CGFloat) -> UIColor {
//    return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1);
//}
//
//func rgbaColor(_ red:CGFloat, _ green:CGFloat, _ blue:CGFloat, _ alpha:CGFloat) -> UIColor {
//    return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha);
//}


extension UIColor {
    convenience init(_ red:CGFloat, _ green:CGFloat, _ blue:CGFloat) {
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1);
    }
    
    convenience init(_ red:CGFloat, _ green:CGFloat, _ blue:CGFloat, _ alpha:CGFloat) {
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}
		
