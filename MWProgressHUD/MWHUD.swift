//
//  MWHUD.swift
//  MWProgressHUD
//
//  Created by wangwei on 2018/9/11.
//  Copyright © 2018年 wangwei. All rights reserved.
//

import UIKit

/*
 1. 监听键盘的弹出
 */

/*
层级关系：
 frontWindow(containerView) -> hudView -> statusLabel、imageView、customView
                               backgroundView ->
 */

private let mw_maxWidth   = UIScreen.main.bounds.width * 0.6
private let mw_maxHeight  = UIScreen.main.bounds.height * 0.9
private let mw_edgeInsets = UIEdgeInsetsMake(12, 20, 15, 20)

open class MWHUD: UIView {
    
    static let shareView = MWHUD(frame: UIApplication.shared.keyWindow!.bounds)
    
    var _backgroundColor = UIColor.init(red: 242/255.0, green: 75/255.0, blue: 79/255.0, alpha: 1)
    var statusLabelColor = UIColor.white
    var statusLabelFont  = UIFont.systemFont(ofSize: 12)
    var fadeOutTimer: Timer?
    
    var containerView: UIView?
    
    lazy var controlView: UIControl = {
        let controlView = UIControl()
        controlView.frame = UIScreen.main.bounds
        controlView.backgroundColor = UIColor.clear
        controlView.isUserInteractionEnabled = true
        controlView.addTarget(self, action: #selector(controlView(didReceiveTouchEvent:touchs:)), for: .touchUpInside)
        return controlView
    }()
    
    var frontWindow: UIWindow? {
        let windows = UIApplication.shared.windows
        for window in windows.reversed() {
            if window.screen == UIScreen.main, !window.isHidden, window.alpha > 0, window.windowLevel >= UIWindowLevelNormal {
                return window
            }
        }
        return nil
    }
   
    lazy var backgroundView: UIView = {
        let backgroundView = UIView()
        insertSubview(backgroundView, belowSubview: hudView)
        return backgroundView
    }()
    
    lazy var hudView: UIVisualEffectView = {
        let hudView = UIVisualEffectView()
        addSubview(hudView)
        return hudView
    }()
    
    lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.backgroundColor = UIColor.clear
        statusLabel.adjustsFontSizeToFitWidth = true
        statusLabel.textAlignment = .center
        statusLabel.baselineAdjustment = .alignCenters
        hudView.contentView.addSubview(statusLabel)
        return statusLabel
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        hudView.contentView.addSubview(imageView)
        return imageView
    }()

    var customView: UIView?

}


// MARK: - private Methods
extension MWHUD {
    
    @objc func controlView(didReceiveTouchEvent sender: Any, touchs: UIEvent) {
        
    }
    
    private func fadeIn() {
        
        let animationClosure = {
            self.customView?.alpha = 1
            self.hudView.alpha = 1
            self.statusLabel.isHidden = true
            self.imageView.isHidden = true
        }
        
        let completeClosure = {
            self.hudView.removeFromSuperview()
            self.hudView.frame = CGRect(x: 0, y: 0, width: self.customView!.frame.width, height: self.customView!.frame.height)
            self.frontWindow?.addSubview(self.hudView)
            self.hudView.contentView.addSubview(self.customView!)
            
            self.fadeOutTimer = Timer(timeInterval: 0, target:self, selector: #selector(self.dimissHud), userInfo: nil, repeats: false)
            RunLoop.main.add(self.fadeOutTimer!, forMode: .commonModes)
        }
        
        OperationQueue.main.addOperation {
            UIView.animate(withDuration: 1.0, delay: 0, options: [.allowUserInteraction , .curveEaseOut], animations: {
                animationClosure()
            }, completion: { bool in
                completeClosure()
            })
        }
    }
    
    private func fadeOut() {
        
    }
    
    @objc private func dimissHud() {
        self.dimiss(2.0)
    }
    
    private func dimiss(_ delayTime: TimeInterval) {
        
        self.fadeOutTimer = nil
        
        let animationClosure = {
            self.customView?.alpha = 0
            self.hudView.alpha = 0
        }
        
        let completeClosure = {
            self.customView?.removeFromSuperview()
            self.hudView.removeFromSuperview()
        }
        
        OperationQueue.main.addOperation {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayTime) {
                UIView.animate(withDuration: 2.0, delay: 0, options: [.allowUserInteraction , .curveEaseOut], animations: {
                    animationClosure()
                }, completion: { bool in
                    completeClosure()
                })
            }
        }
    }
    
}

// MARK: - confi Methods
extension MWHUD {
    
    func set(activityColor: UIColor) {
        
    }
    
    func set(progressColor: UIColor) {
        
    }
    
    func set(successImage: UIImage) {
        
    }
    
    func set(errorImage: UIImage) {
        
    }
}

// MARK: - Show Methods
extension MWHUD {
    
    /// customView
    func show(customView view: UIView) {

        if view.frame.width == 0 || view.frame.height == 0 { return }
        
        statusLabel.removeFromSuperview()
        imageView.removeFromSuperview()
        if let cv = self.customView { cv.removeFromSuperview() }
        
        self.customView = view
        hudView.contentView.addSubview(view)
        
        fadeIn()
    }
    
    func show(text message: String) {
        imageView.removeFromSuperview()
        statusLabel.text = text
    }
    
    func show(activity message: String?) {
        
    }
    
    func show(progress: CGFloat, message: String? = "") {
        
    }
    
    func show(success message: String) {
        
    }
    
    func show(error message: String) {
        
    }
}

// MARK: - Hiden Methods
extension MWHUD {
    
    func hiden() {
        
    }
    
    func hiden(_: MWHUDNoParam) {
        
    }
}

