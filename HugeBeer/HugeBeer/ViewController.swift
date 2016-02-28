//
//  ViewController.swift
//  HugeBeer
//
//  Created by Luis Armando Chávez Soto on 27/02/16.
//  Copyright © 2016 Yamblet. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import Material

class ViewController: UIViewController {

    var currentUser:FAuthData!
    
    @IBOutlet weak var forgetPasswordButton: FlatButton!
    @IBOutlet weak var newUserButton: FlatButton!
    @IBOutlet weak var fieldsContent: MaterialPulseView!
    
    // LOGIN BUTTONS
    
    @IBOutlet weak var facebookButton: FlatButton!
    @IBOutlet weak var googleButton: FlatButton!
    @IBOutlet weak var loginButton: FlatButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ref = Firebase(url: "https://hugebeer.firebaseio.com")
        ref.observeAuthEventWithBlock({ authData in
            if authData != nil {
                // user authenticated
                self.setUserActive(authData)
            } else {
                // No user is signed in
            }
        })
        
        self.prepareButtons()
    }


    @IBAction func facebookLoginAction(sender: FlatButton) {
        self.FBLogin()
    }

}

extension ViewController{
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    func FBLogin(){
        let ref = Firebase(url: "https://hugebeer.firebaseio.com")
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self) { (facebookResult, facebookError) -> Void in
            
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
            } else if facebookResult.isCancelled {
                print("Facebook login was cancelled.")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                ref.authWithOAuthProvider("facebook", token: accessToken,
                    withCompletionBlock: { error, authData in
                        if error != nil {
                            print("Login failed. \(error)")
                        } else {
                            print("Logged in! \(authData)")
                            self.setUserActive(authData)
                        }
                })
            }
        }

    }
    
    func setUserActive(authData:FAuthData){
        self.currentUser = authData
        
        print(authData.uid!)
        
        // 1 - Get the ref
        let activeUsersRef = Firebase(url: "https://hugebeer.firebaseio.com/Online")
        
        // 2 - Create a unique ref
        let singleUserRef = activeUsersRef.childByAppendingPath(authData.uid!)
        
        // 3 - Add them to the list of online users
        
        let treeData = ["id": self.currentUser.providerData["id"]!, "displayName":self.currentUser.providerData["displayName"]!,"email":self.currentUser.providerData["email"]!,"profileImageURL":self.currentUser.providerData["profileImageURL"]!]
        singleUserRef.updateChildValues(treeData)
        
        // 4 - When they drop their connection, remove them
        singleUserRef.onDisconnectRemoveValue()

    }
    

    func prepareButtons(){
        
        self.forgetPasswordButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.newUserButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        self.forgetPasswordButton.titleLabel!.font = RobotoFont.lightWithSize(11)
        self.newUserButton.titleLabel!.font = RobotoFont.lightWithSize(11)
        
        self.fieldsContent.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        
        self.fieldsContent.layer.cornerRadius = 5
        self.fieldsContent.layer.masksToBounds = true

        
        self.forgetPasswordButton.pulseColor = UIColor.whiteColor()
        self.newUserButton.pulseColor = UIColor.whiteColor()
        
        self.loginButton.pulseColor = UIColor.whiteColor()
        self.facebookButton.pulseColor = UIColor.whiteColor()
        self.googleButton.pulseColor = UIColor.whiteColor()

    }
}


