//
//  ComicDetailViewController.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/8.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import UIKit

class ComicDetailViewController: BaseViewController, ComicItemViewDelegate {

    var model: ComicModel?
    
    var itemView: ComicItemView?
    
    lazy var whiteView: UIView = {
        let tempView: UIView = UIView(frame: CGRect(x: 0, y: 183, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 183))
        tempView.backgroundColor = UIColor.white
        return tempView
    }()
    
    lazy var recentLabel: UILabel = {
        let tempLabel: UILabel = UILabel(frame: CGRect(x: 110, y: 140, width: SCREEN_WIDTH - 120, height: 20))
        tempLabel.textColor = UIColor.red
        tempLabel.font = UIFont.systemFont(ofSize: 12)
        return tempLabel
    }()
    
    lazy var detailLabel: UILabel = {
        let tempLabel: UILabel = UILabel(frame: CGRect(x: 5, y: 40, width: SCREEN_WIDTH - 10, height: 35))
        tempLabel.font = UIFont.systemFont(ofSize: 14)
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        addBackItem()
        addRightItem(imageName: "download") { (btn) in
            btn.isEnabled = false
        }
        createUI()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    }
    
    
    func createUI() -> Void {
        let imageView:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 400))
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.2
        view.addSubview(imageView)
        
        view.addSubview(whiteView)
        
        let coverImage:UIImageView = UIImageView(frame: CGRect(x: 0, y: 80, width: 105, height: 138))
        coverImage.layer.cornerRadius = 5
        coverImage.layer.masksToBounds = true
        view.addSubview(coverImage)
        
        if SDImageCache.shared().diskImageExists(withKey: model?.comicId) {
            imageView.image = SDImageCache.shared().imageFromDiskCache(forKey: model?.comicId)
        }else {
            imageView.sd_setImage(with: URL(string: (self.model?.images)!) as URL!, completed: { (image, error, cacheType, url) in
                SDImageCache.shared().store(image, forKey: self.model?.comicId, toDisk: true)
            })
        }
        coverImage.image = SDImageCache.shared().imageFromDiskCache(forKey: model?.comicId)
        
        let titleLabel: UILabel = UILabel(frame: CGRect(x: coverImage.frame.maxX + 5, y: 80, width: SCREEN_WIDTH - coverImage.frame.maxX - 5, height: 20))
        titleLabel.text = model?.name
        titleLabel.textColor = UIColor.white
        view.addSubview(titleLabel)
        
        let authorLabel: UILabel = UILabel(frame: CGRect(x: titleLabel.frame.origin.x, y: titleLabel.frame.maxY + 10, width: titleLabel.frame.size.width, height: 20))
        authorLabel.text = String(format: "作者：%@", (model?.author)!)
        authorLabel.textColor = UIColor(white: 0.7, alpha: 1)
        authorLabel.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(authorLabel)
        
        view.addSubview(recentLabel)
        
        let collectBtn: UIButton = UIButton(frame: CGRect(x: coverImage.frame.maxX + 5, y: 5, width: (SCREEN_WIDTH - 105 - 15) / 2, height: 30))
        collectBtn.setImage(UIImage(named:"star2_Gray"), for: .normal)
        collectBtn.setImage(UIImage(named:"star_icon"), for: .selected)
        collectBtn.setTitle("加入收藏", for: .normal)
        collectBtn.setTitle("取消收藏", for: .selected)
        collectBtn.setTitleColor(UIColor.black, for: .normal)
        collectBtn.layer.borderWidth = 1
        collectBtn.layer.cornerRadius = 5
        collectBtn.layer.masksToBounds = true
        collectBtn.addTarget(self, action: #selector(collect(btn:)), for: .touchUpInside)
        whiteView.addSubview(collectBtn)
        
        let readBtn: UIButton = UIButton(frame: CGRect(x: collectBtn.frame.maxX + 5, y: 5, width: collectBtn.frame.size.width, height: 30))
        readBtn.setTitle("开始阅读", for: .normal)
        readBtn.setTitle("继续阅读", for: .selected)
        readBtn.setTitleColor(UIColor.white, for: .normal)
        readBtn.backgroundColor = UIColor(red: 1, green: 0, blue: 127 / 255.0, alpha: 1)
        readBtn.layer.cornerRadius = 5
        readBtn.layer.masksToBounds = true
        readBtn.addTarget(self, action: #selector(read(btn:)), for: .touchUpInside)
        whiteView.addSubview(readBtn)
        
        detailLabel.text = model?.introduction
        whiteView.addSubview(detailLabel)
        
        let expandBtn: UIButton = UIButton(frame: CGRect(x: SCREEN_WIDTH - 30, y: detailLabel.frame.maxY + 3, width: 20, height: 10))
        expandBtn.setImage(UIImage(named:"xialaDetail"), for: .normal)
        expandBtn.setImage(UIImage(named:"shouqiDetail"), for: .selected)
        expandBtn.addTarget(self, action: #selector(expand(btn:)), for: .touchUpInside)
        whiteView.addSubview(expandBtn)
        
    }
    
    func collect(btn: UIButton) -> Void {
        
    }
    
    func read(btn: UIButton) -> Void {
        
    }
    
    func expand(btn: UIButton) -> Void {
        btn.isSelected = !btn.isSelected
        if btn.isSelected {
            let rect: CGRect = (model?.introduction.boundingRect(with: CGSize(width: SCREEN_WIDTH - 10, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil))!
            UIView.animate(withDuration: 0.15, animations: {
                self.detailLabel.frame = CGRect(x: self.detailLabel.frame.origin.x, y: self.detailLabel.frame.origin.y, width: self.detailLabel.frame.size.width, height: rect.height)
                btn.frame = CGRect(x: SCREEN_WIDTH - 30, y: self.detailLabel.frame.maxY + 3, width: 20, height: 10)
                self.itemView?.frame = CGRect(x: 0, y: self.detailLabel.frame.maxY + 15, width: SCREEN_WIDTH, height: self.whiteView.frame.size.height - self.detailLabel.frame.maxY - 15)
            })
        }else {
            UIView.animate(withDuration: 0.15, animations: {
                self.detailLabel.frame = CGRect(x: 5, y: 40, width: SCREEN_WIDTH - 10, height: 35)
                btn.frame = CGRect(x: SCREEN_WIDTH - 30, y: self.detailLabel.frame.maxY + 3, width: 20, height: 10)
                self.itemView?.frame = CGRect(x: 0, y: self.detailLabel.frame.maxY + 15, width: SCREEN_WIDTH, height: self.whiteView.frame.size.height - self.detailLabel.frame.maxY - 15)
            })
        }
    }
    
    func getData() -> Void {
        let url = String(format: DETAIL_URL, (model?.comicId)!)
        HTTPRequestHelp.shareInstance.GetData(urlString: url, success: { (_, object) in
            let results: Dictionary<String, Any> = (object as! Dictionary<String, Any>)["results"] as! Dictionary<String, Any>
            self.dataArray = results["cartoonChapterList"] as! Array<Dictionary<String, Any>>
            self.recentLabel.text = String(format: "最近更新时间: %@", results["recentUpdateTime"] as! String)
            self.itemView = ComicItemView(frame:CGRect(x: 0, y: self.detailLabel.frame.maxY + 15, width: SCREEN_WIDTH, height: self.whiteView.frame.size.height - self.detailLabel.frame.maxY - 15) , items: self.dataArray.count)
            self.itemView?.itemViewDelegate = self
            self.whiteView.addSubview(self.itemView!)
            }) { (_, error) in
                
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
