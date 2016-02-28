//
//  InfoTableViewCell.swift
//  HugeBeer
//
//  Created by Luis Armando Chávez Soto on 28/02/16.
//  Copyright © 2016 Yamblet. All rights reserved.
//

import UIKit
import Material
import MapKit

class InfoTableViewCell: MaterialTableViewCell {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var optionLabel: MKMapView!
    @IBOutlet weak var pagarButton: RaisedButton!
    @IBOutlet weak var invitarButton: RaisedButton!


}
