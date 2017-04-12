//
//  BaseContentViewController.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/4.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import UIKit

class BaseContentViewController: YZDisplayViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createTitleBar()
    }

    private func createTitleBar() -> Void {
        self.setUpContentViewFrame { (contenView) in
            contenView?.frame = CGRect(x: 0, y: 20, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
            contenView?.backgroundColor = UIColor(red: 241 / 255.0, green: 158 / 255.0, blue: 194 / 255.0, alpha: 1)
        }
        self.setUpTitleGradient { (isShowTitleGradient, titleColorGradientStyle, startR, startG, startB, endR, endG, endB) in
            isShowTitleGradient?.pointee = true
            endR?.pointee = 1
            endG?.pointee = 0
            endB?.pointee = 1
        }
        
        self.setUpCoverEffect { (isShowTitleCover, coverColor, coverCornerRadius) in
            isShowTitleCover?.pointee = true
            coverColor?.pointee = UIColor(white: 0.7, alpha: 0.4)
            coverCornerRadius?.pointee = 10
        }
    }

    
    func hiddenNaviagtor(hidden: Bool) -> Void {
        self.navigationController?.isNavigationBarHidden = hidden;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
