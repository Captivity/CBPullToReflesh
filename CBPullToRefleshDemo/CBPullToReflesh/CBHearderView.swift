//
//  CBHearderView.swift
//  CBPullToRefleshDemo
//
//  Created by 陈超邦 on 2016/8/7.
//  Copyright © 2016年 陈超邦. All rights reserved.
//

import UIKit

class CBHearderView: UIView {
    
    var waveView:CBWaveView!
    var ballView:CBBallView!
    
    init(frame: CGRect, ballSize: CGFloat, moveUpDuration:CFTimeInterval = 0.7, moveUpDist: CGFloat = 32 * 1.5,ballSpaceBetween: CGFloat = 8,backColor: UIColor = UIColor.clear(),color: UIColor = UIColor.groupTableViewBackground()){
        super.init(frame: frame)
        self.backgroundColor = backColor
        waveView = CBWaveView.init(frame: frame, color: color)
        self.addSubview(waveView)
        
        ballView = CBBallView.init(frame: frame, circleSize: ballSize, moveUpDuration: moveUpDuration,moveUpDist: moveUpDist, ballSpaceBetween: ballSpaceBetween, color: color)
        ballView.isHidden = true
        self.addSubview(ballView)
        
        waveView.didEndPull = {
            self.ballView.isHidden = false
            self.ballView.startAnimation()
        }
        
    }
    
    func endingAnimation(_ complition:(()->())? = nil) {
        ballView.endAnimation()
        complition?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func wave(_ y: CGFloat) {
        waveView.wave(y)
    }
    
    func didRelease(_ y: CGFloat) {
        waveView.didRelease(bendDist: y)
    }
    
}
