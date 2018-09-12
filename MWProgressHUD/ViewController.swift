//
//  ViewController.swift
//  MWProgressHUD
//
//  Created by wangwei on 2018/9/11.
//  Copyright © 2018年 wangwei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func infoAction(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            MWHUD.show(success: "xxxxxxxxxx")
        case 2:
            MWHUD.show(error: "xxxxxxxxxx")
        case 3:
             MWHUD.show(text: "hahahahhaahahah")
        case 4:
            let view = MWCustomHUD.loadV()
            view.set(imagString: "info", addCount: "\(count)", addDesc: "\(count)")
            view.backgroundColor = UIColor.red
            view.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
            MWHUD.show(customView: view)
        case 5:
            break
//            MWHUD.show
        default:
            break
        }
    }
    

}

