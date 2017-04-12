//
//  CComicViewController.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/7.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import UIKit

class CategoryViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CATEGORYCELL")
        self.view.addSubview(self.collectionView)
        self.getData()
    }

    private func getData() -> Void {
        let rootDict:Dictionary<String, Array<Dictionary<String, String>>>
        if self.urlString == "" {
            let path:String? = Bundle.main.path(forResource: "PictureCategory", ofType: "plist")
            rootDict = NSDictionary(contentsOfFile: path!) as! Dictionary<String, Array<Dictionary<String, String>>>
            let array:Array = rootDict["results"]!
            
            for dict in array {
                let model:CategoryModel = CategoryModel(dict: dict)
                self.dataArray.append(model)
            }
            self.collectionView.reloadData()
            
        }else {
            HTTPRequestHelp.shareInstance.GetData(urlString: CATEGORY_URL, success: { (_, object) in
                let results = (object as! Dictionary<String, Any>)["results"] as! Array<Dictionary<String, String>>
                for dict in results {
                    let model: CategoryModel = CategoryModel(dict: dict)
                    self.dataArray.append(model)
                }
                self.collectionView.reloadData()
                }, failue: { (_, error) in
                    
            })
        }
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
