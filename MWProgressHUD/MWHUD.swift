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
    
    private func fadeIn(_ type: MWHUDType) {
        
        OperationQueue.main.addOperation {
            
            let animationClosure = { (type: MWHUDType) in
                
                self.hudView.alpha = 1
                switch type {
                case .text:
                    self.customView?.alpha = 0
                    self.imageView.alpha = 0
                    self.statusLabel.alpha = 1
                    
                case .textAndimage:
                    self.customView?.alpha = 0
                    self.imageView.alpha = 1
                    self.statusLabel.alpha = 1
                    
                case .textAndprogress(let text):
                    print(text ?? "")
                    
                case .textAndhud:
                    self.customView?.alpha = 0
                    self.imageView.alpha = 0
                    self.statusLabel.alpha = 1
                    
                case .customView:
                    self.customView?.alpha = 1
                    self.statusLabel.alpha = 0
                    self.imageView.alpha = 0
                }
            }
            
            let completeClosure = { (type: MWHUDType) in
                
                switch type {
                case .text(let text):
                    self.customView?.removeFromSuperview()
                    self.imageView.removeFromSuperview()
                    self.statusLabel.text = text
                    
                case .textAndimage(let text, let image):
                    self.customView?.removeFromSuperview()
                    self.imageView.isHidden = false
                    self.statusLabel.text = text
                    self.imageView.image = image
                    
                case .textAndprogress(let text):
                    print(text ?? "")
                    
                case .textAndhud:
                    self.customView?.removeFromSuperview()
                    self.imageView.removeFromSuperview()
                    self.statusLabel.isHidden = false
                    
                case .customView(let view):
                    if let oldCustomView = self.customView { oldCustomView.removeFromSuperview() }
                    if let v = view {
                        self.customView = view
                        self.hudView.contentView.addSubview(v)
                        self.customView?.alpha = 1
                        self.statusLabel.removeFromSuperview()
                        self.imageView.removeFromSuperview()
                    }
                }
                
//                self.hudView.removeFromSuperview()
                self.hudView.frame = CGRect(x: 0, y: 0, width: self.customView!.frame.width, height: self.customView!.frame.height)
                self.frontWindow?.addSubview(self.hudView)
                self.hudView.contentView.addSubview(self.customView!)
                
                self.dimissHud()
//                self.fadeOutTimer = Timer(timeInterval: 0, target:self, selector: #selector(self.dimissHud), userInfo: nil, repeats: false)
//                RunLoop.main.add(self.fadeOutTimer!, forMode: .commonModes)
            }
            
            UIView.animate(withDuration: 1.0, delay: 0, options: [.allowUserInteraction , .curveEaseOut], animations: {
                animationClosure(type)
            }, completion: { bool in
                completeClosure(type)
            })
        }
    }
    
    private func fadeOut() {
        
    }
    
    @objc private func dimissHud() {
        self.dimiss(2.0)
    }
    
    private func dimiss(_ delayTime: TimeInterval) {
        
        print("dimiss")
        
        self.fadeOutTimer = nil
        
//        OperationQueue.main.addOperation {
        
            let animationClosure = {
                self.customView?.alpha = 0
                self.hudView.alpha = 0
            }
            
            let completeClosure = {
                self.customView?.removeFromSuperview()
                self.customView?.removeFromSuperview()
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayTime) {
                UIView.animate(withDuration: 1.0, delay: 0, options: [.allowUserInteraction , .curveEaseOut], animations: {
                    animationClosure()
                }, completion: { bool in
                    completeClosure()
                })
            }
//        }
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
        fadeIn(.customView(view))
    }
    
    func show(text message: String) {
        fadeIn(.text(message))
    }
    
    func show(success message: String) {
        fadeIn(.textAndimage(text: message, image: UIImage(named: "toast_success")))
    }
    
    func show(error message: String) {
        fadeIn(.textAndimage(text: message, image: UIImage(named: "toast_error")))
    }
    
    func show(activity message: String?) {
        
    }
    
    func show(progress: CGFloat, message: String? = "") {
        
    }
}

// MARK: - Hiden Methods
extension MWHUD {
    
    func hiden() {
        
    }
    
    func hiden(_: MWHUDNoParam) {
        
    }
}

