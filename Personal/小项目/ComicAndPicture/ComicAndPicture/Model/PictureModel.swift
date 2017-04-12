//
//  PictureModel.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/8.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import UIKit

class PictureModel: NSObject {
    var pic_id:String?
    var qhimg_thumb_url:String?
    var cover_width:NSNumber?
    var cover_height:NSNumber?
    var group_title:String?
    var name: String?
    var icon:Dictionary<String,Any>?
    var next:String?
    var total_count:NSNumber?
    var qhimg_url:String?
    var downurl:String?
    var url_l:String?
    var l_height:String?
    var l_width:String?
    
    init(dict:Dictionary<String, Any>) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "id" {
            pic_id = value as? String
        }
    }
}
