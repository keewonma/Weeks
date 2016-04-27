//
//  SecondViewController.swift
//  Weeks
//
//  Created by Jonathan Ma on 4/23/16.
//  Copyright © 2016 Jonathan Ma. All rights reserved.
//

import UIKit
import ElasticTransition

class SecondViewController: UIViewController {

    var transition: ElasticTransition!
    let rightGestureRecognizer = UIScreenEdgePanGestureRecognizer()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup gesture recognizer
        view.backgroundColor = UIColor(patternImage: UIImage(named: "iPhone 6_3@1x")!)

        rightGestureRecognizer.addTarget(self, action: "handleRightPan:")
        rightGestureRecognizer.edges = .Right
        view.addGestureRecognizer(rightGestureRecognizer)
    }
    
    // MARK: Elastic Transition Setup
    
    func handleRightPan(pan: UIPanGestureRecognizer) {
        if pan.state == .Began {
            transition.dissmissInteractiveTransition(self, gestureRecognizer: pan, completion: nil)
        } else {
            transition.updateInteractiveTransition(gestureRecognizer: pan)
        }
    }
    
    // MARK: UI Setup
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}
