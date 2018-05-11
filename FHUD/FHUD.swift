//
//  FHUD.swift
//  FHUD
//
//  Created by Frank.he on 2018/5/7.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import Foundation

public class FHUD: UIView {

    // MARK: - class method

    public class func show(_ mode: FHUDMode, onView view: UIView? = nil, animated: Bool = true) -> FHUD {
        
        let superView = view ?? FHUD.window()
        let hud = FHUD.init(mode, superView)
        superView.addSubview(hud)
        hud.showAnimated(animated)
        return hud
    }
    
    public class func hide(onView: UIView? = nil, animated: Bool = true) {
        
        let superView = onView ?? FHUD.window()
        if let hud = FHUD.hudForView(view: superView) {
            hud.hideAnimated(animated)
        }
    }
    
    private class func hudForView(view: UIView) -> FHUD? {
        let subviews = view.subviews //.reversed()
        for subview in subviews {
            if subview is FHUD {
                return subview as? FHUD
            }
        }
        return nil
    }
    
    private class func window() -> UIWindow {
        if let widow = UIApplication.shared.keyWindow {
            return widow
        }
        else {
            fatalError("keyWindow is nil")
        }
    }
    
    var mode: FHUDMode = .prompt(title: "") {
        didSet {
            bezelView = bezelViewFor(mode)
        }
    }
    
    public var progress = 0.0 {
        didSet {
            if case .progress = mode,
                let proressView = bezelView as? FHUDView {
                proressView.progress = progress
            }
        }
    }
    
    private var backgoundView: FHUDBackgroundView!
    private lazy var bezelView: UIView = {
        return  self.bezelViewFor(mode)
    }()
    
    // MARK: - life cycle
    
    convenience init(_ mode: FHUDMode, _ superView: UIView) {
        self.init(frame: superView.bounds)
        self.mode = mode
        self.commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if case .flash = mode {
            return nil
        }
        else if case .prompt = mode {
            return nil
        }
        return super.hitTest(point, with: event)
    }
    
    deinit {
        print(#file+" "+#function)
    }
    
    // MARK: - private method

    private func commonInit() {
        setUpSubview()
    }
    
    private func setUpSubview() {
        
        let backgroundView = FHUDBackgroundView(frame: self.bounds)
        self.addSubview(backgroundView)
        self.addSubview(bezelView)
    }
    
    private func bezelViewFor(_ mode: FHUDMode) -> UIView {
        switch mode {
        case .progress(let progressMode, let title):
            return FHUDView.init(progressMode, title)
        case .flash(let image, let title):
            return FHUDFlashView(image, title)
        case .prompt(let title):
            return FHUDPromptView(title)

        }
    }
    
    fileprivate func done() {
        self.layer.removeAllAnimations()
        self.bezelView.layer.removeAllAnimations()
        self.removeFromSuperview()
    }
    
    // MARK: - animated

    func showAnimated(_ animated: Bool) {
        if animated {
            let opaqueAnimate = CABasicAnimation(keyPath: "opacity")
            opaqueAnimate.fromValue = 0.3
            opaqueAnimate.toValue = 1
            opaqueAnimate.autoreverses = false
            opaqueAnimate.repeatCount = 0
            opaqueAnimate.duration = 0.2
            opaqueAnimate.isRemovedOnCompletion = false
            self.layer.add(opaqueAnimate, forKey: "opaqueAnimate")

            let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.fromValue = 0.9
            scaleAnimation.toValue = 1
            scaleAnimation.autoreverses = false
            scaleAnimation.repeatCount = 0
            scaleAnimation.duration = 0.2
            scaleAnimation.isRemovedOnCompletion = false
            self.bezelView.layer.add(scaleAnimation, forKey: "scaleAnimation")
        }
    }
    
    func hideAnimated(_ animated: Bool) {
        if animated {
            let opaqueAnimate = CABasicAnimation(keyPath: "opacity")
            opaqueAnimate.fromValue = 1
            opaqueAnimate.toValue = 0.1
            opaqueAnimate.autoreverses = false
            opaqueAnimate.fillMode = kCAFillModeForwards
            opaqueAnimate.repeatCount = 0
            opaqueAnimate.duration = 0.2
            opaqueAnimate.isRemovedOnCompletion = false
            opaqueAnimate.delegate = self
            self.layer.add(opaqueAnimate, forKey: "opaqueAnimate")
            
            let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.fromValue = 1
            scaleAnimation.toValue = 0.9
            scaleAnimation.autoreverses = false
            scaleAnimation.fillMode = kCAFillModeForwards
            scaleAnimation.repeatCount = 0
            scaleAnimation.duration = 0.2
            scaleAnimation.isRemovedOnCompletion = false
            self.bezelView.layer.add(scaleAnimation, forKey: "scaleAnimation")
        }
        else {
            self.done()
        }
    }
}

extension FHUD: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.done()
    }
}
