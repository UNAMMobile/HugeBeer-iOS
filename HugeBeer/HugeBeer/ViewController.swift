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

class ViewController: UIViewController {

    var currentUser:FAuthData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ref = Firebase(url: "https://hugebeer.firebaseio.com")
        ref.observeAuthEventWithBlock({ authData in
            if authData != nil {
                // user authenticated
                print(authData.providerData["displayName"])
            } else {
                // No user is signed in
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginFB(sender: UIButton) {
        self.FBLogin()
    }

}

extension ViewController{

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
                            
                            self.currentUser = authData
                        }
                })
            }
        }
        

    }
    

}
