//
//  ListMenuViewController.swift
//  HugeBeer
//
//  Created by Luis Armando Chávez Soto on 28/02/16.
//  Copyright © 2016 Yamblet. All rights reserved.
//

import UIKit
import RESideMenu
import Firebase

class ListMenuViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    let options:[String] = ["Eventos","Tarjetas","Promociones","Perfil","Amigos", "Notificaciones","Cerrar Sesión"]
    
    let ref = Firebase(url: "https://hugebeer.firebaseio.com")


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: UITableView Delegate & Datasource
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! OptionTableViewCell
        
        cell.optionLabel.text = self.options[indexPath.row]
        cell.optionImage.image = UIImage(named: "\(indexPath.row+1)")
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row{
            
        case 0:
            self.sideMenuViewController.setContentViewController(self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController"), animated: true)
            self.sideMenuViewController.hideMenuViewController()
            break
            
        case 1:
            
            break
            
        case 6:
            
            ref.unauth()

            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let rootView: UIViewController = storyboard.instantiateViewControllerWithIdentifier("videoVC")
            UIApplication.sharedApplication().keyWindow?.rootViewController = rootView

            
            break
            
        default:
            break
            
        }
        
    }

}
