//
//  ComicViewController.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/4.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import UIKit

class ComicViewController: BaseViewController {

    var searchName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        addBackItem()
        self.getdata()
        self.createRefresh(scrollView: tableView) { () in
            self.getdata()
        }
    }
    
    func getdata() {
        
        let url = String(format: self.urlString!, self.page, searchName)
        HTTPRequestHelp.shareInstance.GetData(urlString: url, success: { (task, object) in
            if self.page == 1 {
                self.dataArray.removeAll()
            }
            let rootDict: Dictionary<String, AnyObject> =  (object as! Dictionary<String, AnyObject>)
            let arr: Array<Dictionary<String, String>> = rootDict["results"] as! Array<Dictionary<String, String>>
            for dict in arr{
                let model:ComicModel = ComicModel(dict: dict)
                self.dataArray.append(model)
            }
            self.tableView.reloadData()
            if arr.count == 0 {
                MMProgressHUD.show(withTitle: "没有更多数据")
            }
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
        }) { (task, error) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
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
