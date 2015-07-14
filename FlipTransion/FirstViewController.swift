//
//  FisrtViewController.swift
//  FlipTransion
//
//  Created by BourneWeng on 15/7/13.
//  Copyright (c) 2015年 Bourne. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIViewControllerTransitioningDelegate {

    private var percentDrivenTransition: UIPercentDrivenInteractiveTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitioningDelegate = self

        //添加手势，用以Push
        addScreenEdgePanGestureRecognizer(self.view, edges: UIRectEdge.Right)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let secondVC = segue.destinationViewController as! SecondViewController
        secondVC.transitioningDelegate = self
        addScreenEdgePanGestureRecognizer(secondVC.view, edges: UIRectEdge.Left)
        
        super.prepareForSegue(segue, sender: sender)
    }
    
    func edgePanGesture(edgePan: UIScreenEdgePanGestureRecognizer) {
        let progress = abs(edgePan.translationInView(UIApplication.sharedApplication().keyWindow!).x) / UIApplication.sharedApplication().keyWindow!.bounds.width
        
        if edgePan.state == UIGestureRecognizerState.Began {
            self.percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            if edgePan.edges == UIRectEdge.Right {
                self.performSegueWithIdentifier("present", sender: nil)
            } else if edgePan.edges == UIRectEdge.Left {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        } else if edgePan.state == UIGestureRecognizerState.Changed {
            self.percentDrivenTransition?.updateInteractiveTransition(progress)
        } else if edgePan.state == UIGestureRecognizerState.Cancelled || edgePan.state == UIGestureRecognizerState.Ended {
            if progress > 0.5 {
                self.percentDrivenTransition?.finishInteractiveTransition()
            } else {
                self.percentDrivenTransition?.cancelInteractiveTransition()
            }
            self.percentDrivenTransition = nil
        }
    }

    //动画Push
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BWFlipTransionPush()
    }
    //动画Pop
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BWFlipTransionPop()
    }

    //百分比Push
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.percentDrivenTransition
    }
    //百分比Pop
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.percentDrivenTransition
    }
    
    func addScreenEdgePanGestureRecognizer(view: UIView, edges: UIRectEdge) {
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: Selector("edgePanGesture:"))
        edgePan.edges = edges
        view.addGestureRecognizer(edgePan)
    }
}
