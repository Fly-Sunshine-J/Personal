//
//  ComicModel.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/4.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import UIKit

class ComicModel: NSObject {
    var comicId:String = ""
    var name:String = ""
    var images:String = ""
    var author:String = ""
    var categorys:String = ""
    var introduction:String = ""
    var readMode:String = ""
    var updateType:String = ""
    var updateValue:String = ""
    var totalChapterCount:String = ""
    var updateInfo = ""
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "id" {
            self.comicId = value as! String
        }
    }
    
    init(dict:Dictionary<String, Any>){
        super.init()
        setValuesForKeys(dict)
    }
}
