//
//  ComicViewController.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/2.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import UIKit

class ComicContentViewController: BaseContentViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        
        let titleArray:[String] = ["推荐","热评","新作","更新","搜索"];
        let urlStrings:[String] = [TJ_URL, RP_URL, XZ_URL, GX_URL, SS_URL];
        
        for i in 0..<titleArray.count {
            let vc:ComicViewController
            if i == 4 {
                vc = SearchViewController()
            }else {
                vc = ComicViewController()
            }
            vc.title = titleArray[i]
            vc.urlString = urlStrings[i]
            self.addChildViewController(vc)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
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
