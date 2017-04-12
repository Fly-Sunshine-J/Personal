//
//  PictureViewController.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/2.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import UIKit

class PictureContentViewController: BaseContentViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var titleArray:[String] = ["最新", "番库", "精品"]
        var urlStrings: [String] = [ZX_URL, FK_URL, JP_URL]
        for i in 0 ..< titleArray.count {
            let vc:PictureViewController = PictureViewController()
            vc.urlString = urlStrings[i]
            vc.title = titleArray[i]
            if i == 1 {
                vc.categoryId = "%E4%BA%8C%E6%AC%A1%E5%85%83"
            }else {
                vc.categoryId = "164"
            }
            self.addChildViewController(vc)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hiddenNaviagtor(hidden: true)
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
