//
//  MeViewController.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/2.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import UIKit

class MeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
        self.view.backgroundColor = UIColor(red: 178 / 255.0, green: 127 / 255.0, blue: 255 / 255.0, alpha: 1)
        createBtns()
    }
    
    func createBtns() {
        let images: [String] = ["我的收藏", "清除缓存", "已下载", "已阅读"]
        for i in 0..<images.count {
            let btn: UIButton = UIButton(type: .custom)
            btn.frame = CGRect(x: 50, y: (SCREEN_HEIGHT - 212) / 2 + 53.0 * CGFloat(i), width: SCREEN_WIDTH - 100, height: 53)
            btn.setImage(UIImage(named:images[i]), for: .normal)
            switch i {
            case 0:
                btn.setBackgroundImage(UIImage(named: "上底_1"), for: .normal)
            case 3:
                btn.setBackgroundImage(UIImage(named: "下底_1"), for: .normal)
            default:
                btn.setBackgroundImage(UIImage(named: "中底_1"), for: .normal)
            }
            btn.setTitle(images[i], for: .normal)
            btn.tag = 500 + i
            btn.addTarget(self, action: #selector(click), for: .touchUpInside)
            btn.contentHorizontalAlignment = .left
            btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 00, right: 0)
            btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 70, bottom: 0, right: 0)
            view.addSubview(btn)
        }
    }
    
    func click(btn: UIButton) -> Void {
        switch btn.tag {
        case 500: break
        case 501:
            let alert: UIAlertController = UIAlertController(title: "清除缓存", message: String(format: "缓存大小%0.2fM,确定要清除缓存", Double(SDImageCache.shared().getSize()) / 1024.0 / 1024.0), preferredStyle: .alert)
            let delete: UIAlertAction = UIAlertAction(title: "确定", style: .destructive, handler: { (_) in
                SDImageCache.shared().clearDisk()
            })
            let cancel: UIAlertAction = UIAlertAction(title: "取消", style: .default, handler: { (_) in
                
            })
            alert.addAction(cancel)
            alert.addAction(delete)
            self.present(alert, animated: true, completion: nil)
        case 502: break
        case 503: break
        default:
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
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
