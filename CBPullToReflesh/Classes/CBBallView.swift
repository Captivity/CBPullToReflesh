// CBBallView.swift
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

private var upDuration: Double!
private var ballSize: CGFloat!
private var ballSpace: CGFloat!
private var SuperFrameWidth: CGFloat!;

public class CBBallView: UIView {
    
    var didStarUpAnimation: (()->())?
    var circleMoveView: CircleMoveView?
    var endFloatAnimation: (()->())?
    
    init(frame: CGRect,circleSize: CGFloat = 20, moveUpDuration:CFTimeInterval, moveUpDist:CGFloat, ballSpaceBetween:CGFloat = 5, color:UIColor) {
        
        upDuration = moveUpDuration
        ballSize = circleSize
        ballSpace = ballSpaceBetween
        SuperFrameWidth = frame.width
        
        super.init(frame:frame)
        
        for i in stride(from: 3, through: 0, by: -1) {
            circleMoveView = CircleMoveView.init(frame: frame,circleSize: circleSize, moveUpDist: moveUpDist, color: color)
            circleMoveView!.tag = 100 + i
            self.addSubview(circleMoveView!)
            
            self.didStarUpAnimation = {
                for i in stride(from: 3, through: 0, by: -1) {
                    self.circleMoveView = self.viewWithTag(100 + i) as? CircleMoveView
                    self.circleMoveView!.circleLayer.startAnimationUp(ballTag: i)
                }
            }
            self.endFloatAnimation = {
                for i in stride(from: 3, through: 0, by: -1) {
                    self.circleMoveView = self.viewWithTag(100 + i) as? CircleMoveView
                    self.circleMoveView!.circleLayer.stopFloatAnimation(ballTag: i)
                }
            }
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation() {
        didStarUpAnimation!()
    }
    
    func endAnimation() {
        endFloatAnimation!()
    }
}

class CircleMoveView: UIView {
    
    var circleLayer: CircleLayer!
    
    init(frame: CGRect, circleSize: CGFloat, moveUpDist: CGFloat, color: UIColor) {
        super.init(frame: frame)
        
        circleLayer = CircleLayer(
            size: circleSize,
            moveUpDist: moveUpDist,
            superViewFrame: self.frame,
            color: color
        )
        self.layer.addSublayer(circleLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CircleLayer :CAShapeLayer,CAAnimationDelegate {
    
    var timer:Timer?
    var moveUpDist: CGFloat!
    var didEndAnimation: (()->())?
    
    var layerTag: Int?
    
    init(size:CGFloat, moveUpDist:CGFloat, superViewFrame:CGRect, color:UIColor) {
        self.moveUpDist = moveUpDist
        let selfFrame = CGRect(x: 0, y: 0, width: superViewFrame.size.width, height: superViewFrame.size.height)
        super.init()
        
        let radius:CGFloat = size / 2
        self.frame = selfFrame
        let center = CGPoint(x: superViewFrame.size.width / 2, y: superViewFrame.size.height/2)
        let startAngle = 0
        let endAngle = Double.pi * 2
        let clockwise: Bool = true
        self.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: clockwise).cgPath
        self.fillColor = color.withAlphaComponent(1).cgColor
        self.strokeColor = self.fillColor
        self.lineWidth = 0
        self.strokeEnd = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimationUp(ballTag: Int) {
        layerTag = ballTag
        let distance_left = (ballSize + ballSpace) * (1.5 - CGFloat(ballTag))
        self.moveUp(distance_up:moveUpDist, distance_left: distance_left)
    }
    
    func endAnimation(_ complition:(()->())? = nil) {
        didEndAnimation = complition
    }
    
    func moveUp(distance_up: CGFloat,distance_left: CGFloat) {
        
        self.isHidden = false
        let move = CAKeyframeAnimation(keyPath: "position")
        let angle_1 = atan(Double(abs(distance_left)) / Double(distance_up))
        let angle_2 = Double.pi -  angle_1 * 2
        let radii: Double = pow((pow(Double(distance_left), 2)) + pow(Double(distance_up), 2), 1 / 2) / (cos(angle_1) * 2)
        let centerPoint: CGPoint = CGPoint(x: SuperFrameWidth/2 - distance_left, y: CGFloat(radii) - distance_up)
        var endAngle: CGFloat = CGFloat(3 * Double.pi/2)
        var startAngle: CGFloat = CGFloat(3 / 2 * Double.pi - angle_2)
        var bezierPath = UIBezierPath()
        var clockwise:Bool = true
        
        if distance_left > 0 {
            clockwise = false
            startAngle =  CGFloat(3 / 2 * Double.pi + angle_2)
            endAngle = CGFloat(3 * Double.pi/2)
        }
        
        bezierPath = UIBezierPath.init(arcCenter: centerPoint, radius: CGFloat(radii), startAngle: startAngle , endAngle: endAngle, clockwise: clockwise)
        move.path = bezierPath.cgPath
        move.duration = upDuration
        move.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        move.fillMode = kCAFillModeForwards
        move.isRemovedOnCompletion = false
        move.delegate = self
        self.add(move, forKey: move.keyPath)
    }
    
    func floatUpOrDown() {
        let move = CAKeyframeAnimation(keyPath: "position.y")
        move.values = [0,1,2,3,4,5,4,3,2,1,0,-1,-2,-3,-4,-5,-4,-3,-2,-1,0]
        move.duration = 1
        move.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        move.isAdditive = true
        move.fillMode = kCAFillModeForwards
        move.isRemovedOnCompletion = false
        self.add(move, forKey: move.keyPath)
    }
    
    func stopFloatAnimation(ballTag: Int) {
        timer?.invalidate()
        self.isHidden = true
        self.removeAllAnimations()
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        let animation:CAKeyframeAnimation = anim as! CAKeyframeAnimation
        if animation.keyPath == "position" {
            let timeDelay: TimeInterval =  Double(layerTag!) * 0.2
            timer = Timer.schedule(delay: timeDelay, repeatInterval: 1, handler: { (timer) -> Void in
                self.floatUpOrDown()
            })
        }
    }
}
