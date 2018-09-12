//
//  MWCustomHUD.swift
//  MWProgressHUD
//
//  Created by wangwei on 2018/9/12.
//  Copyright © 2018年 wangwei. All rights reserved.
//

import UIKit

class MWCustomHUD: UIView {

    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var addCountL: UILabel!
    @IBOutlet weak var adddescL: UILabel!
    
    func set(imagString: String, addCount: String, addDesc: String ) {
        imageV.image = UIImage(named: imagString)
        addCountL.text = addCount
        adddescL.text  = addDesc
    }
    
    static func loadV() -> MWCustomHUD {
        return Bundle.main.loadNibNamed("MWCustomHUD", owner: self, options: nil)!.last as! MWCustomHUD
    }
    
}
