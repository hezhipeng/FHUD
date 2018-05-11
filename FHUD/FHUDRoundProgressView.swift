//
//  FHUDRoundProgressView.swift
//  FHUD
//
//  Created by Frank.he on 2018/5/11.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import UIKit

class FHUDRoundProgressView: UIView {

    private let progressTintColor = UIColor.white.withAlphaComponent(1)
    private let backgroundTintColor = UIColor.white.withAlphaComponent(1)
    
    public var progress = 0.0 {
        didSet {
            DispatchQueue.main.async {
                self.setNeedsDisplay()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let lineWidth = 2.0
        let center = CGPoint.init(x: self.bounds.midX, y: self.bounds.midY)
        let radius = self.bounds.maxX/2 - CGFloat(lineWidth/2)
        let startAngle = -(Double.pi / 2); // 90
        let endAngle = (2 * Double.pi) + startAngle;
        
        let processBackgroundPath = UIBezierPath()
        processBackgroundPath.lineWidth = CGFloat(lineWidth)
        processBackgroundPath.lineCapStyle = .butt
        processBackgroundPath.addArc(withCenter: center, radius: CGFloat(radius), startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        backgroundTintColor.set()
        processBackgroundPath.stroke()
        
        let processPath = UIBezierPath()
        processPath.lineWidth = CGFloat(lineWidth * 2)
        let processRadius = self.bounds.maxX/2 - CGFloat(lineWidth)
        
        progressTintColor.setFill()
        let endAngle1 = progress * 2 * Double.pi + startAngle
        processPath.addArc(withCenter: center, radius: CGFloat(processRadius), startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle1), clockwise: true)
        progressTintColor.set()
        processPath.stroke()
    }

}
