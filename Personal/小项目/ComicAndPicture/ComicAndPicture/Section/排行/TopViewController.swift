//
//  TopViewController.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/2.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import UIKit

class TopViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "排行榜"
        tableView.frame = CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64)
        view.addSubview(tableView)
        createRefresh(scrollView: tableView) { 
            self.getData()
        }
        getData()
    }
    
    private func getData() {
        HTTPRequestHelp.shareInstance.GetData(urlString: String(format: TOP_URL, page), success: { (_, object) in
            let results = (object as! Dictionary<String, Any>)["results"] as! Array<Dictionary<String, Any>>
            if self.page == 1 {
                self.dataArray.removeAll()
            }
            for dict in results {
                self.dataArray.append(dict)
            }
            if results.count == 0 {
                MMProgressHUD.show(withTitle: "没有更多数据")
            }
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            }) { (_, error) in
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: TopCell? = tableView.dequeueReusableCell(withIdentifier: "TOPCELL") as? TopCell
        if cell == nil {
            cell = TopCell(style: .default, reuseIdentifier: "TOPCELL")
        }
        let dict = self.dataArray[indexPath.row] as! Dictionary<String, String>
        cell?.imagesView?.sd_setImage(with: URL(string: dict["images"]!))
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 666 * SCREEN_WIDTH / 1600
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict: Dictionary<String, Any> = dataArray[indexPath.row] as! Dictionary<String, Any>
        let vc: ComicViewController  = ComicViewController()
        vc.title = dict["name"] as? String
        vc.page = 1
        vc.searchName =  dict["id"] as! String
        vc.urlString = RQB_URL
        navigationController?.pushViewController(vc, animated: true)
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
