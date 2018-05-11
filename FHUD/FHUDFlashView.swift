//
//  FHUDFlashView.swift
//  FHUD
//
//  Created by Frank.he on 2018/5/9.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import Foundation

class FHUDFlashView: FHUDBackgroundView {
    
    static let defaultFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100))
    static let defaultFrameForTitle = CGRect(origin: CGPoint.zero, size: CGSize(width: 120, height: 120))

    private var image: UIImage!
    private var title: String?

    convenience init(_ image: UIImage, _ title: String? = nil) {
        self.init(frame: (title != nil) ? FHUDFlashView.defaultFrameForTitle : FHUDFlashView.defaultFrame)
        self.image = image
        self.title = title
        commonInit()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.mode = .blur
        self.backgroundColor =  UIColor.black.withAlphaComponent(0.8)
        self.layer.cornerRadius = 5.0;
        
        self.imageView.image = image
        self.titleLabel.text = title
        
        self.addSubview(imageView)
        self.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let superview = self.superview {
            
            let viewWidth = superview.frame.size.width
            let viewHeight = superview.frame.size.height
            
            let x = viewWidth / 2.0
            let y = viewHeight / 2.0
            
            self.center = CGPoint.init(x: x, y: y)
            
            let center = CGPoint.init(x: self.bounds.midX, y: self.bounds.midY)
            if let _ = title {
                self.imageView.bounds = CGRect(x: 0, y: 0, width: 60, height: 60)
                self.imageView.center = CGPoint(x: center.x, y: 45)
                
                self.titleLabel.bounds = CGRect(x: 0, y: 0, width: self.bounds.maxX, height: 20)
                self.titleLabel.center = CGPoint(x: center.x, y: self.bounds.maxY - 20)
            }
            else {
                self.imageView.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
                self.imageView.center = center
            }
            
        }
    }
    
    // MARK: - get and set
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
//        imageView.backgroundColor = .white
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = UIColor.white.withAlphaComponent(0.85)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        return label
    }()
}
