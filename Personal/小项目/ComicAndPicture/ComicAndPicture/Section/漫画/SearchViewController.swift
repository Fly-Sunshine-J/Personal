//
//  SearchViewController.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/7.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import UIKit

class SearchViewController: ComicViewController, UITextFieldDelegate {
    
    var searchField: UITextField?
    var searchBtn: UIButton?
    var headerLabel: UILabel?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.frame = CGRect(x: 0, y: 40, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 40 - 64)
        self.createUI()
        NotificationCenter.default.addObserver(self, selector: #selector(backKeyboard), name:NSNotification.Name(rawValue: YZDisplayViewClickOrScrollDidFinshNote), object: nil)
    }

    private func createUI() -> Void {
        self.searchField = UITextField(frame: CGRect(x: 10, y: 10, width: SCREEN_WIDTH - 100, height: 30))
        self.searchField?.borderStyle = UITextBorderStyle.roundedRect
        self.searchField?.placeholder = "请输入搜索关键词"
        self.searchField?.clearButtonMode = UITextFieldViewMode.whileEditing
        self.searchField?.leftView = UIImageView(image: UIImage(named: "search"))
        self.searchField?.leftViewMode = UITextFieldViewMode.always
        self.searchField?.delegate = self
        self.view.addSubview(self.searchField!)
        
        self.searchBtn = UIButton(frame: CGRect(x: (self.searchField?.frame.maxX)! + 10, y: 10, width: 70, height: 30))
        self.searchBtn?.setTitle("搜索", for: UIControlState.normal)
        self.searchBtn?.backgroundColor = UIColor(red: 249 / 255.0, green: 204 / 255.0, blue: 226 / 255.0, alpha: 1)
        self.searchBtn?.setImage(UIImage(named:"buttonSearchImage"), for: UIControlState.normal)
        self.searchBtn?.addTarget(self, action: #selector(search), for: .touchUpInside)
        self.view.addSubview(self.searchBtn!)
        
        self.headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 30))
        self.headerLabel?.text = "为您推荐热搜："
        self.headerLabel?.textColor = UIColor.red
        self.tableView.tableHeaderView = self.headerLabel
    }
    
    func backKeyboard() -> Void {
        self.searchField?.resignFirstResponder()
    }
    
    func search() -> Void {
        self.backKeyboard()
        page = 1
        searchName = (self.searchField?.text)!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        self.getdata()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.backKeyboard()
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
