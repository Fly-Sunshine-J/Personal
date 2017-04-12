//
//  RootViewController.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/1.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.tabBar.barTintColor = UIColor(colorLiteralRed: 233 / 255.0, green: 235 / 255.0, blue: 254 / 255.0, alpha: 1);
        self.tabBar.tintColor = UIColor(colorLiteralRed: 181 / 255.0, green: 229 / 255.0, blue: 181 / 255.0, alpha: 1);
        self.createViewControllers();
    }
    
    
    private func createViewControllers() -> Void {
        let titleArray = ["漫画", "图片", "排行", "分类", "我的"]
        let imageArray = ["TabBarItemComic", "TabBarItemPicture", "TabBarItemTop", "TabBarCategory", "TabBarItemMe"]
        let vcStrings = ["ComicViewController", "PictureViewController", "TopViewController", "CategoryViewController", "MeViewController"]
        var vcs:[BaseViewController] = [];
        
        for i in 0..<titleArray.count {
            let className = "ComicAndPicture." + vcStrings[i]
            let vcClass = NSClassFromString(className) as! BaseViewController.Type
            let vc: BaseViewController = vcClass.init();
            vc.tabBarItem.image = UIImage(named: imageArray[i]);
            vc.tabBarItem.title = titleArray[i];
            vcs.append(vc);
        }
        self.viewControllers = vcs;
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
