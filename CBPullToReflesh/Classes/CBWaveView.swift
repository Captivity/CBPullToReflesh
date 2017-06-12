// CBWaveView.swift
// Copyright (c) 2017 陈超邦.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

public class CBWaveView: UIView {
    
    var waveLayer: CAShapeLayer!
    var bounceDuration: CFTimeInterval!
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
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var bounceAnimation: CAKeyframeAnimation!
    func boundAnimation(bendDist: CGFloat) {
        
        bounceAnimation = CAKeyframeAnimation(keyPath: "path")
        bounceAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        let values = [
            self.wavePath(bendDist: bendDist),
            self.wavePath(bendDist: bendDist * 0.8),
            self.wavePath(bendDist: bendDist * 0.6),
            self.wavePath(bendDist: bendDist * 0.4),
            self.wavePath(bendDist: bendDist * 0.2),
            self.wavePath(bendDist: 0)
        ]
        bounceAnimation.values = values
        bounceAnimation.duration = bounceDuration
        bounceAnimation.isRemovedOnCompletion = false
        bounceAnimation.fillMode = kCAFillModeForwards
        self.waveLayer.add(bounceAnimation, forKey: "return")
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
