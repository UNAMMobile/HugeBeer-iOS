//
//  InfoEventTableViewController.swift
//  HugeBeer
//
//  Created by Luis Armando Chávez Soto on 28/02/16.
//  Copyright © 2016 Yamblet. All rights reserved.
//

import UIKit
import Material
import MapKit
import CoreLocation

private let kTableHeaderCutAway: CGFloat = 0.0
private var kTableHeaderHeight: CGFloat = 250.0

class InfoEventTableViewController: UITableViewController {

    var headerView: UIView!

    var service:Service!
    
    @IBOutlet weak var eventName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        eventName.text = service.nombre!
        
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        
        let effectiveHeight:CGFloat = kTableHeaderHeight-kTableHeaderCutAway/2
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight + 60)
        
        updateHeaderView()

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateHeaderView()
    }
    
    func updateHeaderView() {
        let effectiveHeight = kTableHeaderHeight-kTableHeaderCutAway/2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        if tableView.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y + kTableHeaderCutAway/2
        }
        
        headerView.frame = headerRect
    }
    
    // MARK: - Scroll view Delegate
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 436
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellInfo", forIndexPath: indexPath) as! InfoTableViewCell

        cell.pagarButton.setTitle("Pagar", forState: .Normal)
        cell.pagarButton.titleLabel!.font = RobotoFont.mediumWithSize(20)
        
        
        cell.invitarButton.setTitle("Invitar Amigos", forState: .Normal)
        cell.invitarButton.backgroundColor = MaterialColor.purple.accent1
        cell.invitarButton.titleLabel!.font = RobotoFont.mediumWithSize(20)

        // Configure the cell...
        
        let location:CLLocation = CLLocation(latitude: service.ubicacion!["lat"] as! Double, longitude: service.ubicacion!["lon"] as! Double)
        
        //let location:CLLocation = CLLocation(latitude: 1, longitude: 1)
        
        
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = location.coordinate
        dropPin.title = "Evento"
        cell.optionLabel.addAnnotation(dropPin)
        
        let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(0.001 , 0.001)
        let theRegion:MKCoordinateRegion = MKCoordinateRegionMake(location.coordinate, theSpan)
        cell.optionLabel.setRegion(theRegion, animated: true)


        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    @IBAction func dissmisAction(sender: UIBarButtonItem) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
