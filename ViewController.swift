//
//  ViewController.swift
//  Weeks
//
//  Created by Jonathan Ma on 4/23/16.
//  Copyright © 2016 Jonathan Ma. All rights reserved.
//

import UIKit
import ElasticTransition

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource   {
   
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //let label = ["1", "2", "3", "4"]
    //let imageArray = [UIImage(named: "badge-show"), UIImage(named: "badge-show"), UIImage(named: "badge-show"), UIImage(named: "badge-show")]
    
    // set how many images
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  52
    }
    
    //add images
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        //cell.imageView?.image = self.imageArray[indexPath.row]
        cell.imageView.image = UIImage(named: "badge-show")
        
        return cell
    }
    
    //Elastic Transition
    var transition = ElasticTransition()
    let leftGestureRecognizer = UIScreenEdgePanGestureRecognizer()
    let rightGestureRecognizer = UIScreenEdgePanGestureRecognizer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "iPhone 6_4@1x")!)
        
        // setup the elastic transition
        transition.sticky = true
        transition.showShadow = true
        transition.stiffness = 0.4
        transition.radiusFactor = 0.4
        transition.panThreshold = 0.5
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
    
    
    //Elastic Transition
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
        
        //Elastic Transition
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
    
    // UI Setup
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    
}

