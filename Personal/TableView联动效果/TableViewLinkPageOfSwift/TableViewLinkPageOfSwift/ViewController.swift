//
//  ViewController.swift
//  TableViewLinkPageOfSwift
//
//  Created by vcyber on 17/4/10.
//  Copyright © 2017年 vcyber. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate let datas = ["UITableView", "UICollectionView"];
    fileprivate lazy var tableView: UITableView = {
        let tableView:UITableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CELL");
        return tableView;
    }();
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(self.tableView);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL");
        cell?.textLabel?.text = datas[indexPath.row];
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(TableViewViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(CollectionViewController(), animated: true)
        default:
            print("default");
        }
    }
}

