//
//  SecondViewController.swift
//  Weeks
//
//  Created by Jonathan Ma on 4/23/16.
//  Copyright © 2016 Jonathan Ma. All rights reserved.
//

import UIKit
import ElasticTransition
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit


class SecondViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    // MARK: Elastic Transition setup
    var transition: ElasticTransition!
    let rightGestureRecognizer = UIScreenEdgePanGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Facebook Login Button
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
        }
        else
        {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            //Some other options: "user_about_me", "user_birthday", "user_hometown", "user_likes", "user_interests", "user_photos", "friends_photos", "friends_hometown", "friends_location", "friends_education_history"
            
            loginView.delegate = self
        }
        
        // MARK: background color and setup gesture recognizer
        view.backgroundColor = UIColor(patternImage: UIImage(named: "iPhone 6_3@1x")!)

        rightGestureRecognizer.addTarget(self, action: "handleRightPan:")
        rightGestureRecognizer.edges = .Right
        view.addGestureRecognizer(rightGestureRecognizer)
    }
    
    // MARK: Facebook Delegate Methods
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, last_name, picture.type(large)"]).startWithCompletionHandler { (connection, result, error) -> Void in
            //let strFirstName: String = (result.objectForKey("first_name") as? String)!
            //let strLastName: String = (result.objectForKey("last_name") as? String)!
            //let strPictureURL: String = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)!
            //self.lblName.text = "Welcome, \(strFirstName) \(strLastName)"
            //self.ivUserProfileImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: strPictureURL)!)!)
        }
        print("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        //ivUserProfileImage.image = nil
        //lblName.text = ""
        print("User Logged Out")
    }
    
    // MARK: Elastic Transition Setup
    
    func handleRightPan(pan: UIPanGestureRecognizer) {
        if pan.state == .Began {
            transition.dissmissInteractiveTransition(self, gestureRecognizer: pan, completion: nil)
        } else {
            transition.updateInteractiveTransition(gestureRecognizer: pan)
        }
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                print("User Email is: \(userEmail)")
            }
        })
    }
    
    // MARK: UI Setup
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}
