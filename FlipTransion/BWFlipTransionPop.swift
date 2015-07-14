//
//  BWFlipTransionPop.swift
//  FlipTransion
//
//  Created by BourneWeng on 15/7/13.
//  Copyright (c) 2015年 Bourne. All rights reserved.
//

import UIKit

class BWFlipTransionPop: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.8
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! SecondViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! FirstViewController
        let container = transitionContext.containerView()
        container.addSubview(toVC.view)
        
        //改变m34
        var transfrom = CATransform3DIdentity
        transfrom.m34 = -0.002
        container.layer.sublayerTransform = transfrom
        
        //设置anrchPoint 和 position
        let initalFrame = transitionContext.initialFrameForViewController(fromVC)
        toVC.view.frame = initalFrame
        toVC.view.layer.anchorPoint = CGPointMake(0, 0.5)
        toVC.view.layer.position = CGPointMake(0, initalFrame.height / 2.0)
        toVC.view.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_2), 0, 1, 0)
        
        //添加阴影效果
        let shadowLayer = CAGradientLayer()
        shadowLayer.colors = [UIColor(white: 0, alpha: 1).CGColor, UIColor(white: 0, alpha: 0.5).CGColor, UIColor(white: 1, alpha: 0.5)]
        shadowLayer.startPoint = CGPointMake(0, 0.5)
        shadowLayer.endPoint = CGPointMake(1, 0.5)
        shadowLayer.frame = initalFrame
        let shadow = UIView(frame: initalFrame)
        shadow.backgroundColor = UIColor.clearColor()
        shadow.layer.addSublayer(shadowLayer)
        toVC.view.addSubview(shadow)
        shadow.alpha = 1
        
        //动画
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                toVC.view.layer.transform = CATransform3DIdentity
                shadow.alpha = 0
            }) { (finished: Bool) -> Void in
                toVC.view.layer.anchorPoint = CGPointMake(0.5, 0.5)
                toVC.view.layer.position = CGPointMake(CGRectGetMidX(initalFrame), CGRectGetMidY(initalFrame))
                shadow.removeFromSuperview()
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}