//
//  SwiftComboBox.swift
//  SwiftComboBox
//
//  Created by Yigit Serin on 14.01.2019.
//  Copyright © 2019 Yigit Serin. All rights reserved.
//

import Foundation
import UIKit

enum SwiftComboBoxEffectType{
    case dark
    case blur
}

class SwiftComboBoxPresentationController : UIPresentationController {
    
    var effectType: SwiftComboBoxEffectType = .dark
    
    override var frameOfPresentedViewInContainerView : CGRect {
        return CGRect(x: 0, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
    }
    
    override func presentationTransitionWillBegin() {
        
        var dimView: UIView!
        
        if effectType == .dark{
            dimView = UIView()
            dimView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }else if effectType == .blur{
            let blurEffect = UIBlurEffect(style: .extraLight)
            dimView = UIVisualEffectView(effect: blurEffect)
        }
        
        self.containerView?.addSubview(dimView)
        
        dimView.translatesAutoresizingMaskIntoConstraints = false
        let leftConstraint = NSLayoutConstraint(item: dimView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: containerView!, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: dimView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: containerView!, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: dimView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: containerView!, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: dimView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: containerView!, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        containerView!.addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
        
        if effectType == .dark{
            dimView!.addSubview(self.presentedViewController.view)
        }else if effectType == .blur{
            let blurView = dimView as! UIVisualEffectView
            blurView.contentView.addSubview(self.presentedViewController.view)
        }
        
        
        let transitionCoordinator = self.presentedViewController.transitionCoordinator
        
        dimView.alpha = 0
        transitionCoordinator?.animate(alongsideTransition: { (context) -> Void in
            dimView.alpha = 1
        }, completion: { (context) -> Void in
            
        })
        
        //
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(SwiftComboBoxPresentationController.dismissComboBoxSelector(_:)))
        dimView.addGestureRecognizer(tapGR)
    }
    
    @objc fileprivate func dismissComboBoxSelector(_ sender: UITapGestureRecognizer){
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
