//
//  CategoryViewController.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/2.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import UIKit

class CategoryContentViewController: BaseContentViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let titleArr:Array = ["漫画分类", "图片分类"]
        let urlStrings:Array = [CATEGORY_URL, ""]
        
        for i in 0..<titleArr.count {
            let vc:CategoryViewController = CategoryViewController() 
            vc.title = titleArr[i]
            vc.urlString = urlStrings[i]
            self.addChildViewController(vc)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hiddenNaviagtor(hidden: true);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hiddenNaviagtor(hidden: false)
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
