//
//  MWHUD+Extension.swift
//  MWProgressHUD
//
//  Created by wangwei on 2018/9/11.
//  Copyright © 2018年 wangwei. All rights reserved.
//

import UIKit


// MARK: - confi Methods
extension MWHUD {
    
    /// textColor
    class func set(textColor: UIColor) {
        MWHUD.shareView.statusLabelColor = textColor
    }
    
    /// textFont
    class func set(textFont: UIFont) {
        MWHUD.shareView.statusLabelFont = textFont
    }
    
    /// activityColor
    class func set(activityColor: UIColor) {
        MWHUD.shareView.set(activityColor: activityColor)
    }
    
    /// progressColor
    class func set(progressColor: UIColor) {
        MWHUD.shareView.set(progressColor: progressColor)
    }
    
    /// successImage
    class func set(successImage: UIImage) {
        MWHUD.shareView.set(successImage: successImage)
    }
    
    /// errorImage
    class func set(errorImage: UIImage) {
        
    }
}

// MARK: - Show Methods
extension MWHUD {
    
    /// text
    class func show(text message: String) {
        MWHUD.shareView.show(text: message)
    }
    
    /// activity + message
    class func show(activity message: String?) {
        
    }
    
    /// process + message
    class func show(progress: CGFloat, message: String? = "") {
        
    }
    
    /// success + message
    class func show(success message: String) {
        
    }
    
    /// error + message
    class func show(error message: String) {
        
    }
    
    /// customView
    class func show(customView view: UIView) {
        MWHUD.shareView.show(customView: view)
    }
}

// MARK: - Hiden Methods
extension MWHUD {
    
    class func hiden() {
        
    }
    
    class func hiden(_: MWHUDNoParam) {
        
    }
}
