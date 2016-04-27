//
//  ThirdViewController.swift
//  Weeks
//
//  Created by Jonathan Ma on 4/23/16.
//  Copyright © 2016 Jonathan Ma. All rights reserved.
//

import UIKit
import ElasticTransition
import CircleMenu

extension UIColor {
    convenience init(rgb: UInt) {
        self.init (
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

class ThirdViewController: UIViewController, CircleMenuDelegate {
    
    var transition: ElasticTransition!
    let leftGestureRecognizer = UIScreenEdgePanGestureRecognizer()
    
    //    let colors = [UIColor.redColor(), UIColor.grayColor(), UIColor.greenColor(), UIColor.purpleColor()]
    let items: [(icon:String, color: UIColor)] = [
        ("google", UIColor(rgb:0xdd4b39)),
        ("linkedin", UIColor(rgb:0x007bb5)),
        ("twitter", UIColor(rgb:0x55acee)),
        ("facebook", UIColor(rgb:0x3b5998)),
        ("instagram", UIColor(rgb:0xfb3958)),
        ("mainIcon", UIColor.clearColor()),
        ("mainIconSelected", UIColor.whiteColor())
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: setup circlemenu
        let button = CircleMenu(
            frame: CGRect(x: 175, y: 215, width: 50, height: 50),
            normalIcon: "mainIcon",
            selectedIcon: "mainIconSelected",
            buttonsCount: 5,
            duration: 1,
            distance: 150)
        button.delegate = self
        button.layer.cornerRadius = button.frame.size.width / 2.0
        view.addSubview(button)
        
        // MARK: setup gesture recognizers
        view.backgroundColor = UIColor(patternImage: UIImage(named: "iPhone 6_2@1x")!)

        leftGestureRecognizer.addTarget(self, action: "handleLeftPan:")
        leftGestureRecognizer.edges = .Left
        view.addGestureRecognizer(leftGestureRecognizer)
    }
    
    // MARK: Circle Menu Button Configure

    func circleMenu(circleMenu: CircleMenu, willDisplay button: CircleMenuButton, atIndex: Int) {
        button.backgroundColor = items[atIndex].color
        button.setImage(UIImage(imageLiteral: items[atIndex].icon), forState: .Normal)
        
        let highlightedImage = UIImage(imageLiteral: items[atIndex].icon).imageWithRenderingMode(.AlwaysTemplate)
        button.setImage(highlightedImage, forState: .Highlighted)
        button.tintColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    func circleMenu(circleMenu: CircleMenu, buttonWillSelected button: CircleMenuButton, atIndex: Int) {
        print("button will selected: \(atIndex)")
    }
    
    func circleMenu(circleMenu: CircleMenu, buttonDidSelected button: CircleMenuButton, atIndex: Int) {
        print("button did selected: \(atIndex)")
    }


    // MARK: Elastic Transition Setup
    
    func handleLeftPan(pan: UIPanGestureRecognizer) {
        if pan.state == .Began{
            transition.dissmissInteractiveTransition(self, gestureRecognizer: pan, completion: nil)
        }else{
            transition.updateInteractiveTransition(gestureRecognizer: pan)
        }
    }
    
    // MARK: UI Setup
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
