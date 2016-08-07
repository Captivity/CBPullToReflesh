//
//  CBWaveView.swift
//  CBPullToRefleshDemo
//
//  Created by 陈超邦 on 2016/8/7.
//  Copyright © 2016年 陈超邦. All rights reserved.
//

import UIKit

class CBWaveView: UIView {
    
    var waveLayer:CAShapeLayer!
    var bounceDuration:CFTimeInterval!
    var didEndPull: (()->())?
    
    init(frame:CGRect,bounceDuration:CFTimeInterval = 0.2,color:UIColor) {
        super.init(frame:frame)
        self.bounceDuration = bounceDuration
        
        waveLayer = CAShapeLayer(layer: self.layer)
        waveLayer.lineWidth = 0
        waveLayer.strokeColor = color.cgColor
        waveLayer.fillColor = color.cgColor
        self.layer.addSublayer(waveLayer)
    }
    
    func wave(_ y:CGFloat) {
        self.waveLayer.path = self.wavePath(bendDist: y)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func boundAnimation(bendDist: CGFloat) {
        let bounce = CAKeyframeAnimation(keyPath: "path")
        bounce.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        let values = [
            self.wavePath(bendDist: bendDist),
            self.wavePath(bendDist: bendDist * 0.8),
            self.wavePath(bendDist: bendDist * 0.6),
            self.wavePath(bendDist: bendDist * 0.4),
            self.wavePath(bendDist: bendDist * 0.2),
            self.wavePath(bendDist: 0)
        ]
        bounce.values = values
        bounce.duration = bounceDuration
        bounce.isRemovedOnCompletion = false
        bounce.fillMode = kCAFillModeForwards
        //        bounce.delegate = self
        self.waveLayer.add(bounce, forKey: "return")
    }
    
    func wavePath(bendDist:CGFloat) -> CGPath {
        let width = self.frame.width
        let height = self.frame.height
        
        let bottomLeftPoint = CGPoint(x: 0, y: height)
        let topMidPoint = CGPoint(x: width / 2,  y: -bendDist)
        let bottomRightPoint = CGPoint(x: width, y: height)
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: bottomLeftPoint)
        bezierPath.addQuadCurve(to: bottomRightPoint, controlPoint: topMidPoint)
        bezierPath.addLine(to: bottomLeftPoint)
        return bezierPath.cgPath
    }
    
    func didRelease(bendDist: CGFloat) {
        self.boundAnimation(bendDist: bendDist)
        didEndPull?()
    }
    
    func endAnimation() {
        self.waveLayer.removeAllAnimations()
    }
    
}
