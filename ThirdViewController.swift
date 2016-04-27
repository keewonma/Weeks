//
//  ThirdViewController.swift
//  Weeks
//
//  Created by Jonathan Ma on 4/23/16.
//  Copyright © 2016 Jonathan Ma. All rights reserved.
//

import UIKit
import ElasticTransition

class ThirdViewController: UIViewController {

    
    var transition: ElasticTransition!
    let leftGestureRecognizer = UIScreenEdgePanGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup gesture recognizers
        view.backgroundColor = UIColor(patternImage: UIImage(named: "iPhone 6_2@1x")!)

        leftGestureRecognizer.addTarget(self, action: "handleLeftPan:")
        leftGestureRecognizer.edges = .Left
        view.addGestureRecognizer(leftGestureRecognizer)
    }
    
    // Elastic Transition Setup
    
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
