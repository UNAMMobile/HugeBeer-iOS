//
//  MenuViewController.swift
//  HugeBeer
//
//  Created by Luis Armando Chávez Soto on 28/02/16.
//  Copyright © 2016 Yamblet. All rights reserved.
//

import UIKit
import RESideMenu

class MenuViewController: RESideMenu,RESideMenuDelegate{

    override func awakeFromNib(){
        
        self.menuPreferredStatusBarStyle = UIStatusBarStyle.LightContent
        self.contentViewShadowColor = UIColor.blackColor()
        self.contentViewShadowOffset = CGSizeMake(0, 0)
        self.contentViewShadowOpacity = 0.6
        self.contentViewShadowRadius = 12
        self.contentViewShadowEnabled = true
        
        self.contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController")
        self.leftMenuViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MenuViewController")
        self.rightMenuViewController = nil
        
        self.delegate = self;
        
    }
    
}
