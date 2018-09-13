//
//  MWHUDType.swift
//  MWProgressHUD
//
//  Created by wangwei on 2018/9/11.
//  Copyright © 2018年 wangwei. All rights reserved.
//

import Foundation
import UIKit

typealias MWHUDNoParam = (()->())?

enum MWHUDType {
    case text(String?)
    case textAndimage(text: String?, image: UIImage?)
    case textAndprogress(String?)
    case textAndhud(String?)
    case customView(UIView?)
}
