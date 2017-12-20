//
//  ViewController.swift
//  alertview
//
//  Created by Vijay Adhikari on 20/12/17.
//  Copyright © 2017 Vijay Adhikari. All rights reserved.
//
import UIKit
import QuartzCore

class CAVTransitioner : NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController)
        -> UIPresentationController? {
            return MyPresentationController(
                presentedViewController: presented, presenting: presenting)
    }
}

class MyPresentationController : UIPresentationController {
    
    func decorateView(_ v:UIView) {
        v.layer.cornerRadius = 8
        
        let motionEffectX = UIInterpolatingMotionEffect(
            keyPath:"center.x", type:.tiltAlongHorizontalAxis)
        motionEffectX.maximumRelativeValue = 10.0
        motionEffectX.minimumRelativeValue = -10.0
        let motionEffectY = UIInterpolatingMotionEffect(
            keyPath:"center.y", type:.tiltAlongVerticalAxis)
        motionEffectY.maximumRelativeValue = 10.0
        motionEffectY.minimumRelativeValue = -10.0
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [motionEffectX,motionEffectY]
        v.addMotionEffect(motionEffectGroup)
    }
    
    override func presentationTransitionWillBegin() {
        self.decorateView(self.presentedView!)
        let vc = self.presentingViewController
        let v = vc.view!
        let con = self.containerView!
        let shadow = UIView(frame:con.bounds)
        shadow.backgroundColor = UIColor(white:0, alpha:0.4)
        shadow.alpha = 0
        con.insertSubview(shadow, at: 0)
        shadow.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let tc = vc.transitionCoordinator!
        tc.animate(alongsideTransition: { _ in
            shadow.alpha = 1
        }) { _ in
            v.tintAdjustmentMode = .dimmed
        }
    }
    
    override func dismissalTransitionWillBegin() {
        let vc = self.presentingViewController
        let v = vc.view!
        let con = self.containerView!
        let shadow = con.subviews[0]
        let tc = vc.transitionCoordinator!
        tc.animate(alongsideTransition: { _ in
            shadow.alpha = 0
        }) { _ in
            v.tintAdjustmentMode = .automatic
        }
    }
    
    override var frameOfPresentedViewInContainerView : CGRect {
        // we want to center the presented view at its "native" size
        // I can think of a lot of ways to do this,
        // but here we just assume that it *is* its native size
        let v = self.presentedView!
        let con = self.containerView!
        v.center = CGPoint(x: con.bounds.midX, y: con.bounds.midY)
        return v.frame.integral
    }
    
    override func containerViewWillLayoutSubviews() {
        // deal with future rotation
        // again, I can think of more than one approach
        let v = self.presentedView!
        v.autoresizingMask = [
            .flexibleTopMargin, .flexibleBottomMargin,
            .flexibleLeftMargin, .flexibleRightMargin
        ]
        v.translatesAutoresizingMaskIntoConstraints = true
    }
    
}

extension CAVTransitioner { // UIViewControllerTransitioningDelegate
    func animationController(
        forPresented presented:UIViewController,
        presenting: UIViewController,
        source: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            return self
    }
    
    func animationController(
        forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            return self
    }
}

extension CAVTransitioner : UIViewControllerAnimatedTransitioning {
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?)
        -> TimeInterval {
            return 0.25
    }
    
    func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerVw = transitionContext.containerView
        
        let fromTransition = transitionContext.view(forKey: .from)
        let toTransition = transitionContext.view(forKey: .to)
        
        
        if let v2 = toTransition { // presenting
            containerVw.addSubview(v2)
            let scale = CGAffineTransform(scaleX: 1.6, y: 1.6)
            v2.transform = scale
            v2.alpha = 0
            UIView.animate(withDuration: 0.25, animations: {
                v2.alpha = 1
                v2.transform = .identity
            }) { _ in
                transitionContext.completeTransition(true)
            }
        } else if let v1 = fromTransition { // dismissing
            UIView.animate(withDuration: 0.25, animations: {
                v1.alpha = 0
            }) { _ in
                transitionContext.completeTransition(true)
            }
        }
        
    }
    
}

