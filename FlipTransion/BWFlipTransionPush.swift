//
//  BWFlipTransionPush.swift
//  FlipTransion
//
//  Created by BourneWeng on 15/7/13.
//  Copyright (c) 2015年 Bourne. All rights reserved.
//

import UIKit

class BWFlipTransionPush: NSObject, UIViewControllerAnimatedTransitioning {
   
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.8
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! FirstViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! SecondViewController
        let container = transitionContext.containerView()
        container.addSubview(toVC.view)
        container.bringSubviewToFront(fromVC.view)
        
        //改变m34
        var transfrom = CATransform3DIdentity
        transfrom.m34 = -0.002
        container.layer.sublayerTransform = transfrom
        
        //设置anrchPoint 和 position
        let initalFrame = transitionContext.initialFrameForViewController(fromVC)
        toVC.view.frame = initalFrame
        fromVC.view.frame = initalFrame
        fromVC.view.layer.anchorPoint = CGPointMake(0, 0.5)
        fromVC.view.layer.position = CGPointMake(0, initalFrame.height / 2.0)
        
        //添加阴影效果
        let shadowLayer = CAGradientLayer()
        shadowLayer.colors = [UIColor(white: 0, alpha: 1).CGColor, UIColor(white: 0, alpha: 0.5).CGColor, UIColor(white: 1, alpha: 0.5)]
        shadowLayer.startPoint = CGPointMake(0, 0.5)
        shadowLayer.endPoint = CGPointMake(1, 0.5)
        shadowLayer.frame = initalFrame
        let shadow = UIView(frame: initalFrame)
        shadow.backgroundColor = UIColor.clearColor()
        shadow.layer.addSublayer(shadowLayer)
        fromVC.view.addSubview(shadow)
        shadow.alpha = 0
        
        //动画
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                fromVC.view.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_2), 0, 1, 0)
                shadow.alpha = 1.0
            }) { (finished: Bool) -> Void in
                fromVC.view.layer.anchorPoint = CGPointMake(0.5, 0.5)
                fromVC.view.layer.position = CGPointMake(CGRectGetMidX(initalFrame), CGRectGetMidY(initalFrame))
                fromVC.view.layer.transform = CATransform3DIdentity
                shadow.removeFromSuperview()
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}
