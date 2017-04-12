//
//  PictureViewController.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/8.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import UIKit

class PictureViewController: BaseViewController {
    
    var categoryId:String?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(PictureCell.self, forCellWithReuseIdentifier: "PICTURECELL")
        view.addSubview(collectionView)
        getData()
        createRefresh(scrollView: collectionView) { 
            self.getData()
        }
    }
    
    private func getData() {
        let url = String(format: urlString!, categoryId!, page)
        HTTPRequestHelp.shareInstance.GetData(urlString: url, success: { (_, object) in
            let list:Array<Dictionary<String, Any>>
            if self.title == "番库" {
                list = (object as! Dictionary<String, Any>)["item"] as! Array<Dictionary<String, Any>>
            }else {
                list = (object as! Dictionary<String, Any>)["list"] as! Array<Dictionary<String, Any>>
            }
            if self.page == 1 {
                self.dataArray.removeAll()
            }
            for dict in list {
                let model: PictureModel = PictureModel(dict: dict)
                self.dataArray.append(model)
            }
            self.collectionView.reloadData()
            self.collectionView.mj_header.endRefreshing()
            self.collectionView.mj_footer.endRefreshing()
            }) { (_, error) in
                self.collectionView.mj_header.endRefreshing()
                self.collectionView.mj_footer.endRefreshing()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PictureCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PICTURECELL", for: indexPath) as! PictureCell
        cell.configCell(model: dataArray[indexPath.row] as! PictureModel)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH / 2 - 0.5, height: SCREEN_WIDTH / 2 - 0.5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
