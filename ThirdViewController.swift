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

    @IBOutlet weak var ImageView: UIImageView!
    
    var image = UIImage()
    
    var transition: ElasticTransition!
    let leftGestureRecognizer = UIScreenEdgePanGestureRecognizer()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //collection view
        self.ImageView.image = self.image
        
        //setup gesture recognizers
        leftGestureRecognizer.addTarget(self, action: "handleLeftPan:")
        leftGestureRecognizer.edges = .Left
        view.addGestureRecognizer(leftGestureRecognizer)
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
