//
//  AppMacro.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/4.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import Foundation

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

//漫画
//更新
let GX_URL = "http://api.playsm.com/index.php?size=20&r=cartoonCategory/getCartoonSetListByCategory&id=20&page=%d"
//推荐
let TJ_URL = "http://api.playsm.com/index.php?size=20&r=cartoonCategory/getCartoonSetListByCategory&id=5&page=%d"
//热评
let RP_URL = "http://api.playsm.com/index.php?size=20&r=cartoonCategory/getCartoonSetListByCategory&id=4&page=%d"
//新作
let XZ_URL = "http://api.playsm.com/index.php?size=20&r=cartoonCategory/getCartoonSetListByCategory&id=21&page=%d"
//搜索
let SS_URL = "http://api.playsm.com/index.php?size=9&r=cartoonSet/list&page=%d&searchName=%@"

//榜单
let TOP_URL = "http://api.playsm.com/index.php?size=10&r=cartoonBillBoard/list&page=%d&"

//人气榜 
let RQB_URL = "http://api.playsm.com/index.php?size=10&r=cartoonBillBoard/getCartoonSetListByBillBoard&page=%d&id=%@&"

//详情页面
let DETAIL_URL = "http://api.playsm.com/index.php?r=v3/cartoonSet/detail&id=%@&"

//下载链接
let DOWNLOAD_URL = "http://api.playsm.com/index.php?r=cartoonChapter/albumList&isSize=1&chapterId=%@&"

//漫画阅读
let LOOK_URL = "http://api.playsm.com/index.php?size=10&orderType=1&r=cartoonChapter/albumList&page=1&isSize=1&chapterId=%@&"


//漫画分类
let CATEGORY_URL = "http://api.playsm.com/index.php?size=999&r=cartoonCategory/list&page=1&"

//分类点击
let CATEGORY_CLICK_URL = "http://api.playsm.com/index.php?size=12&r=cartoonCategory/getCartoonSetListByCategory&page=%d&id=%@&"


//漫图
//最新
let ZX_URL = "http://image.so.com/zj?ch=wallpaper&src=srp&listtype=new&t1=%@&sn=%d&pn=20"

//番库
let FK_URL = "http://211.155.84.158/?build=1.0&appVersion=1&ch=wandou&openudid=865863024597523&screen=1536x2560&appName=single5&device=android&method=search&query=%@&type=album&offset=%d&limit=30"

let FKPIC_URL = "http://211.155.84.158/?build=1.0&appVersion=1&ch=wandou&openudid=865863024597523&screen=1536x2560&appName=single5&device=android&do_fav_userid=0&method=album.get&id=%@&offset=%d&limit=30"

//精品
let JP_URL = "http://image.so.com/zj?ch=wallpaper&src=srp&listtype=hot&t1=%@&sn=%d&pn=20"

//图片点击
let PICTURE_URL = "http://image.so.com/zvj?ch=wallpaper&src=srp&listtype=%@&pn=20&id=%@"



let PICTURE_PREFIX_URL = "http://tupian.nikankan.com"

