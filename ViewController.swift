//
//  ViewController.swift
//  Weeks
//
//  Created by Jonathan Ma on 4/23/16.
//  Copyright © 2016 Jonathan Ma. All rights reserved.
//

import UIKit
import ElasticTransition

class ViewController: UIViewController, UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let imageArray = [UIImage(named: "badge-video"), UIImage(named: "badge-show")]
    
    //Elastic Transition
    var transition = ElasticTransition()
    let leftGestureRecognizer = UIScreenEdgePanGestureRecognizer()
    let rightGestureRecognizer = UIScreenEdgePanGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // setup the elastic transition
        transition.sticky = true
        transition.showShadow = true
        transition.stiffness = 1.5
        transition.radiusFactor = 0.4
        transition.panThreshold = 0.4
        transition.transformType = .TranslateMid
        
        //setup gesture recognizers
        leftGestureRecognizer.addTarget(self, action: "handleLeftPan:")
        leftGestureRecognizer.edges = .Left
        view.addGestureRecognizer(leftGestureRecognizer)
        rightGestureRecognizer.addTarget(self, action: "handleRightPan:")
        rightGestureRecognizer.edges = .Right
        view.addGestureRecognizer(rightGestureRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberofItemsinSection section: Int) -> Int {
        
        return self.imageArray.count
    
    }
    
    func collectionView(collectionView: UICollectionView, cellforItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        cell.imageView?.image = self.imageArray[indexPath.row]
        
        
    }
    //use your own panGestureRecognizer and call dissmissInteractiveTransition in your handler
    
    func handleLeftPan(pan: UIPanGestureRecognizer) {
        if pan.state == .Began {
            transition.edge = .Left
            transition.startInteractiveTransition(self, segueIdentifier: "GreenBlue", gestureRecognizer: pan)
        } else {
            transition.updateInteractiveTransition(gestureRecognizer: pan)
        }
    }
    
    func handleRightPan(pan: UIPanGestureRecognizer) {
        if pan.state == .Began {
            transition.edge = .Right
            transition.startInteractiveTransition(self, segueIdentifier: "RedBlue", gestureRecognizer: pan)
        } else {
            transition.updateInteractiveTransition(gestureRecognizer: pan)
        }
    }
    //In prepareForSegue, assign the transition to be the transitioningDelegate of the destinationViewController. Also, dont forget to set the modalPresentationStyle to .Custom
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController
        vc.transitioningDelegate = transition
        vc.modalPresentationStyle = .Custom
        if segue.identifier == "GreenBlue" {
            if let vc = vc as? SecondViewController {
                vc.transition = transition
            }
        } else {
            if let vc = vc as? ThirdViewController {
                vc.transition = transition
            }
        }
    }
    
    // MARK: UI Setup
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    
}

