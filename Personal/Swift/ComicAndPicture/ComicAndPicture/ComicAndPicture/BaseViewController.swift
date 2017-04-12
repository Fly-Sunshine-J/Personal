//
//  BaseViewController.swift
//  ComicAndPicture
//
//  Created by vcyber on 16/11/2.
//  Copyright © 2016年 vcyber. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.pushViewController(BaseViewController(), animated: true);
    }
    
    
    func addBackItem() -> Void {
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30));
        imageView.image = UIImage(named: "back");
        imageView.isUserInteractionEnabled = true;
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(back))
        imageView.addGestureRecognizer(tap);
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: imageView)
    }
    
    func back() {
        self.navigationController!.popViewController(animated: true);
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
