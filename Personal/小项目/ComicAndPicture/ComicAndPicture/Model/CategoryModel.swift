//
//  CategoryModel.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/7.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import UIKit

class CategoryModel: NSObject {

    var categoryId:String = ""
    var name:String = ""
    var images:String = ""
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "id" {
            self.categoryId = value as! String
        }
    }
    
    init(dict:Dictionary<String, Any>){
        super.init()
        setValuesForKeys(dict)
    }
}
