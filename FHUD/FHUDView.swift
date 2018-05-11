//
//  FHUDView.swift
//  FHUD
//
//  Created by Frank.he on 2018/5/11.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import UIKit

class FHUDView: FHUDBackgroundView {

    static let defaultFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: 80, height: 80))
    static let defaultFrameForTitle = CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100))
    static let styleSize = CGSize(width: 37, height: 37)
    static let styleSizeForTitle = CGSize(width: 45, height: 45)

    internal var progressMode: HUDProgressMode
    private var title: String?
    private var timer: Timer?

    public var progress = 0.0 {
        didSet {
            if case .round = progressMode {
                if let loadStyleView = loadStyleView as? FHUDRoundProgressView {
                    loadStyleView.progress = progress
                }
            }
        }
    }
    
    // MARK: - life cycle
    
    convenience init(_ mode: HUDProgressMode, _ title: String? = nil) {
        self.init(frame: (title != nil) ? FHUDView.defaultFrameForTitle : FHUDView.defaultFrame)
        self.progressMode = mode
        self.title = title
        setupSubviews()
    }
    
    private override init(frame: CGRect) {
        self.progressMode = .default
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func removeFromSuperview() {
        super.removeFromSuperview()
        stopTextAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let superview = self.superview {
            
            let viewWidth = superview.frame.size.width
            let viewHeight = superview.frame.size.height
            
            let x = viewWidth / 2.0
            let y = viewHeight / 2.0
            
            self.center = CGPoint.init(x: x, y: y)
        }
    }
    
    deinit {
        print(#file+" "+#function)
    }
    
    // MARK: - private method

    private func setupSubviews() {
        self.backgroundColor =  UIColor.black.withAlphaComponent(0.8)
        self.layer.cornerRadius = 5.0;
        
        self.addSubview(loadStyleView)
        if let _ = title {
            self.addSubview(titleLabel)
            startTextAnimation()
        }
        self.setNeedsUpdateConstraints()
    }
    
    // MARK: - titleLabel text Animation

    func startTextAnimation() {
        
        if let title = title {
            if title.hasSuffix("...") {
                self.startTimer(enabled: true)
            }
            else {
                self.titleLabel.text = title
            }
        }
    }
    
    func stopTextAnimation() {
        if let timer = timer {
            timer.invalidate()
        }
    }
    
    private func startTimer(enabled: Bool) {
        if enabled {
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTitle), userInfo: nil, repeats: true)
            RunLoop.current.add(timer!, forMode: .defaultRunLoopMode)
            self.updateTitle()
        }
        else {
            stopTextAnimation()
        }
    }
    
    private var i = 3
    @objc private func updateTitle() {
        
        if let title = title {
            i -= 1
            let attri = NSMutableAttributedString(string: title)
            attri.addAttributes([NSAttributedStringKey.foregroundColor: UIColor.clear],
                                range: NSRange(location: attri.length - i, length: i))
            self.titleLabel.attributedText = attri
            if i <= 0 {
                i = 3
            }
        }
    }
    
    // MARK: - get and set

    lazy var loadStyleView: UIView = {
        switch self.progressMode {
        case .default:
            return FHUDIndicatorView()
        case .zoomInOutCycle:
            return FHUDZoomInOutCycleView()
        case .round:
            self.clipsToBounds = false
            return FHUDRoundProgressView.init(frame: CGRect.zero)
        }
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = UIColor.white.withAlphaComponent(0.85)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        return label
    }()
    
    // MARK: - systerm constraints
    
    override func updateConstraints() {
        
        if let _ = title {
            loadStyleView.translatesAutoresizingMaskIntoConstraints = false
            let lCenterX: NSLayoutConstraint = NSLayoutConstraint(item: loadStyleView,
                                                                  attribute: NSLayoutAttribute.centerX,
                                                                  relatedBy:NSLayoutRelation.equal,
                                                                  toItem:self,
                                                                  attribute:NSLayoutAttribute.centerX,
                                                                  multiplier:1.0,
                                                                  constant: 0)
            
            let lCenterY: NSLayoutConstraint = NSLayoutConstraint(item: loadStyleView,
                                                                  attribute: NSLayoutAttribute.centerY,
                                                                  relatedBy:NSLayoutRelation.equal,
                                                                  toItem:self,
                                                                  attribute:NSLayoutAttribute.centerY, multiplier:1.0, constant: -15)
          
            let lwidth: NSLayoutConstraint = NSLayoutConstraint(item: loadStyleView,
                                                               attribute: NSLayoutAttribute.width,
                                                               relatedBy:NSLayoutRelation.equal,
                                                               toItem:nil,
                                                               attribute:NSLayoutAttribute.notAnAttribute,
                                                               multiplier:1.0,
                                                               constant: FHUDView.styleSize.width)
            
            let lheight: NSLayoutConstraint = NSLayoutConstraint(item: loadStyleView,
                                                                attribute: NSLayoutAttribute.height,
                                                                relatedBy:NSLayoutRelation.equal,
                                                                toItem:nil,
                                                                attribute:NSLayoutAttribute.notAnAttribute,
                                                                multiplier:1.0,
                                                                constant: FHUDView.styleSize.height)
            
            self.addConstraints([lCenterX, lCenterY, lwidth, lheight])
            
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            let tCenterX: NSLayoutConstraint = NSLayoutConstraint(item: titleLabel,
                                                                  attribute: NSLayoutAttribute.centerX,
                                                                  relatedBy:NSLayoutRelation.equal,
                                                                  toItem:self,
                                                                  attribute:NSLayoutAttribute.centerX,
                                                                  multiplier:1.0,
                                                                  constant: 0)
            
            let tTop: NSLayoutConstraint = NSLayoutConstraint(item: titleLabel,
                                                              attribute: NSLayoutAttribute.top,
                                                              relatedBy:NSLayoutRelation.equal,
                                                              toItem:loadStyleView,
                                                              attribute:NSLayoutAttribute.bottom,
                                                              multiplier:1.0,
                                                              constant: 10)
            
            let tLeft: NSLayoutConstraint = NSLayoutConstraint(item: titleLabel,
                                                               attribute: NSLayoutAttribute.left,
                                                               relatedBy:NSLayoutRelation.equal,
                                                               toItem:self,
                                                               attribute:NSLayoutAttribute.left,
                                                               multiplier:1.0,
                                                               constant: 5)
            
            let tRight: NSLayoutConstraint = NSLayoutConstraint(item: titleLabel,
                                                                attribute: NSLayoutAttribute.right,
                                                                relatedBy:NSLayoutRelation.equal,
                                                                toItem:self,
                                                                attribute:NSLayoutAttribute.right,
                                                                multiplier:1.0,
                                                                constant: -5)
            self.addConstraints([tCenterX, tTop, tLeft, tRight])
        }
        else {
            loadStyleView.translatesAutoresizingMaskIntoConstraints = false
            let centerX: NSLayoutConstraint = NSLayoutConstraint(item: loadStyleView,
                                                                 attribute: NSLayoutAttribute.centerX,
                                                                 relatedBy:NSLayoutRelation.equal,
                                                                 toItem:self,
                                                                 attribute:NSLayoutAttribute.centerX,
                                                                 multiplier:1.0,
                                                                 constant: 0)
            
            let centerY: NSLayoutConstraint = NSLayoutConstraint(item: loadStyleView,
                                                                 attribute: NSLayoutAttribute.centerY,
                                                                 relatedBy:NSLayoutRelation.equal,
                                                                 toItem:self,
                                                                 attribute:NSLayoutAttribute.centerY,
                                                                 multiplier:1.0,
                                                                 constant: 0)
            
            let width: NSLayoutConstraint = NSLayoutConstraint(item: loadStyleView,
                                                               attribute: NSLayoutAttribute.width,
                                                               relatedBy:NSLayoutRelation.equal,
                                                               toItem:nil,
                                                               attribute:NSLayoutAttribute.notAnAttribute,
                                                               multiplier:1.0,
                                                               constant: FHUDView.styleSize.width)
            
            let height: NSLayoutConstraint = NSLayoutConstraint(item: loadStyleView,
                                                                attribute: NSLayoutAttribute.height,
                                                                relatedBy:NSLayoutRelation.equal,
                                                                toItem:nil,
                                                                attribute:NSLayoutAttribute.notAnAttribute,
                                                                multiplier:1.0,
                                                                constant: FHUDView.styleSize.height)
            
            self.addConstraints([centerX, centerY, width, height])
        }
        super.updateConstraints()
    }
}
