//
//  TableViewViewController.swift
//  TableViewLinkPageOfSwift
//
//  Created by vcyber on 17/4/10.
//  Copyright © 2017年 vcyber. All rights reserved.
//

import UIKit

class TableViewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    fileprivate lazy var leftTableView:UITableView = {
        let tableView:UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: 80, height: self.view.frame.size.height), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 50
        tableView.separatorColor = UIColor.clear
        tableView.register(LeftTableViewCell.self, forCellReuseIdentifier: kLeftTableViewCell)
        return tableView;
    }()
    
    fileprivate lazy var rightTableView:UITableView = {
        let tableView:UITableView = UITableView(frame: CGRect(x: 80, y: 64, width: SCREEN_WIDTH - 80, height: self.view.frame.size.height - 64), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 80
        tableView.register(RightTableViewCell.self, forCellReuseIdentifier: kRightTableViewCell)
        return tableView;
    }()
    
    fileprivate lazy var categoryData = [CategoryModel]();
    fileprivate lazy var foodData = [[FoodModel]]()
    
    fileprivate var selectIndex = 0
    fileprivate var isSCrollDown = true
    fileprivate var lastOffsetY:CGFloat = 0.0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        getData()
        view.addSubview(leftTableView)
        view.addSubview(rightTableView)
        
        leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
        // Do any additional setup after loading the view.
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

extension TableViewViewController {
    fileprivate func getData() -> Void {
        guard let path = Bundle.main.path(forResource: "meituan", ofType: "json") else { return }
        
        guard let data = NSData(contentsOfFile: path) as? Data else { return }
        
        guard let anyObject = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else { return }
        
        guard let dict = anyObject as? [String : Any] else { return }
        
        guard let datas = dict["data"] as? [String : Any] else { return }
        
        guard let foods = datas["food_spu_tags"] as? [[String : Any]] else { return }
        
        for food in foods {
            
            let model = CategoryModel(dict: food)
            categoryData.append(model)
            
            guard let spus = model.spus else { continue }
            var datas = [FoodModel]()
            for fModel in spus {
                datas.append(fModel)
            }
            foodData.append(datas)
        }
    }
}


extension TableViewViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        if leftTableView == tableView{
            return 1
        }else {
            return categoryData.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if leftTableView == tableView {
            return categoryData.count
        }else {
            return foodData[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if leftTableView == tableView {
            let cell:LeftTableViewCell = tableView.dequeueReusableCell(withIdentifier: kLeftTableViewCell, for: indexPath) as! LeftTableViewCell
            cell.name = categoryData[indexPath.row].name
            return cell
        }else {
            let cell: RightTableViewCell = tableView.dequeueReusableCell(withIdentifier: kRightTableViewCell, for: indexPath) as! RightTableViewCell
            cell.foodModel = foodData[indexPath.section][indexPath.row]
            return cell;
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if leftTableView == tableView {
            return nil
        }else {
            let headerView = TableViewHeaderView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 20))
            headerView.nameLabel.text = categoryData[section].name
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if leftTableView == tableView {
            return 0
        }else {
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if rightTableView == tableView && !isSCrollDown && rightTableView.isDragging {
            selectRow(row: section)
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        if rightTableView == tableView && isSCrollDown && rightTableView.isDragging {
            selectRow(row: section + 1)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if leftTableView == tableView {
            selectIndex = indexPath.row
            rightTableView.scrollToRow(at: IndexPath(row: 0, section: selectIndex), at: .top, animated: true)
            leftTableView.scrollToRow(at: IndexPath(row: selectIndex, section: 0), at: .top, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableView = scrollView as! UITableView
        if rightTableView == tableView {
            isSCrollDown = lastOffsetY < scrollView.contentOffset.y
            lastOffsetY = scrollView.contentOffset.y
        }
        
    }
    
    private func selectRow(row:Int) -> Void {
        leftTableView.selectRow(at: IndexPath(row: row, section: 0), animated: true, scrollPosition: .top)
    }
}


