//
//  HTTPRequest.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/2.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import UIKit

class HTTPRequestHelp: NSObject {

    static let shareInstance: HTTPRequestHelp = {
        let instance = HTTPRequestHelp();
        return instance
    }()
    
    func GetData(urlString: String, success:@escaping (URLSessionDataTask, Any) -> Void, failue:@escaping (URLSessionDataTask, Error) -> Void) -> Void {
        MMProgressHUD.show(withTitle: "努力加载中", status: "努力加载中", images: [UIImage(named: "loading_teemo_1")!, UIImage(named: "loading_teemo_2")!])
        MMProgressHUD.setPresentationStyle(MMProgressHUDPresentationStyle.shrink)
        let manager:AFHTTPSessionManager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.timeoutInterval = 10
        manager.get(urlString, parameters: nil, success: { (task, objcet) in
            do {
                let json = try JSONSerialization.jsonObject(with: objcet as! Data, options: JSONSerialization.ReadingOptions.allowFragments)
                success(task, json)
                MMProgressHUD.dismiss(withSuccess: "加载完成")
            } catch{
                let error:NSError = NSError(domain: "CustomeErrorDomain", code: 0000, userInfo: [NSLocalizedDescriptionKey:"解析错误"])
                failue(task, error)
                MMProgressHUD.dismiss(withSuccess: "解析错误")
            }
            
            }) { (task, error) in
                failue(task!, error)
                MMProgressHUD.dismissWithError("网络较慢,请耐心等待一会")
        }
    }
    
}
