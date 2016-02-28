//
//  EventsViewController.swift
//  HugeBeer
//
//  Created by Luis Armando Chávez Soto on 28/02/16.
//  Copyright © 2016 Yamblet. All rights reserved.
//

import UIKit
import SpriteKit
import SIFloatingCollection
import Material
import Firebase

class EventsViewController: UIViewController, SIFloatingCollectionSceneDelegate{

    @IBOutlet weak var skView: SKView!
    private var floatingCollectionScene: BubblesScene!

    @IBOutlet weak var addEventButton: FabButton!
    
    var stream: StreamBase!
    let refService = Firebase(url: "https://hugebeer.firebaseio.com/Eventos")

    @IBOutlet weak var eventButton: RaisedButton!
    
    var index = 0
    
    var isShow:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let img: UIImage? = UIImage(named: "ic_add_white")

        addEventButton.setImage(img, forState: .Normal)
        addEventButton.setImage(img, forState: .Highlighted)
        addEventButton.backgroundColor = UIColor(red: 15/255, green: 103/255, blue: 147/255, alpha: 1)

        self.requestButtonAnimation(true)

        stream = StreamBase(type: Service.self, ref: self.refService)
        stream.delegate = self

        eventButton.setTitle("Ver evento", forState: .Normal)
        eventButton.titleLabel!.font = RobotoFont.mediumWithSize(18)
        
    }
    
    func floatingScene(scene: SIFloatingCollectionScene, didSelectFloatingNodeAtIndex index: Int) {
        self.index = index
        self.requestButtonAnimation(false)
    }
    
    func floatingScene(scene: SIFloatingCollectionScene, didDeselectFloatingNodeAtIndex index: Int) {
        self.requestButtonAnimation(true)
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        floatingCollectionScene = BubblesScene(size: skView.bounds.size)
        floatingCollectionScene.backgroundColor = UIColor.clearColor()
        floatingCollectionScene.floatingDelegate = self
        skView.presentScene(floatingCollectionScene)
        isShow = true

    }


    @IBAction func showEventAction(sender: MaterialButton) {
        floatingCollectionScene.performCommitSelectionAnimation()
        _ = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("eventViewController"), userInfo: nil, repeats: false)

    }
    
    func eventViewController(){
        self.performSegueWithIdentifier("eventeSegue", sender: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "eventeSegue"{
            let navCon = segue.destinationViewController as! UINavigationController
            let vc = navCon.viewControllers.first as! InfoEventTableViewController
            vc.service = stream[index] as! Service
        }
    }


    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    var isInitialLoad = true

    
    func requestButtonAnimation(hide:Bool){
        
        if hide == true{
            self.eventButton.enabled = false
            self.eventButton.animate(MaterialAnimation.translateY(80, duration: 0.5))
        }else{
            self.eventButton.enabled = true
            self.eventButton.animate(MaterialAnimation.translateY(0, duration: 0.5))
        }
        
    }
}


extension EventsViewController:StreamBaseDelegate{
    

    func streamDidFinishInitialLoad(error: NSError?){
        if error == nil{

            isInitialLoad = false
        }
    }
    
    /**
     A batch of changes is beginning.
     */
    func streamWillChange(){}
    
    /**
     A batch of changes has ended.
     */
    func streamDidChange(){
        if isInitialLoad {
            floatingCollectionScene.reloadInputViews()
        } else {
            floatingCollectionScene.reloadInputViews()
        }
    }
    
    /**
     Several items have been added.  These paths indicate where these items will appear
     after the update.
     */
    func streamItemsAdded(paths: [NSIndexPath]){
        
        for indexPath in paths{
            
            let service = stream[indexPath.row] as! Service
            
            let node = BubbleNode.instantiate(service.nombre!, radius:CGFloat(40+rand()%40), strokeColor: SKColor.greenColor(), backgroundColor: SKColor.whiteColor())
            floatingCollectionScene.addChild(node)

            
        }

    }
    
    /**
     Several items have been deleted.  These paths indicate where in the original table
     or collection them items were.
     */
    func streamItemsDeleted(paths: [NSIndexPath]){
    
        floatingCollectionScene.removeFloatinNodeAtIndex((paths.first?.row)!)

    }
    
    /**
     Several items have changed.
     */
    func streamItemsChanged(paths: [NSIndexPath]){
    
        for indexPath in paths{
            let service = stream[indexPath.row] as! Service

            var node = floatingCollectionScene.children[indexPath.row]
            node = BubbleNode.instantiate(service.nombre!, radius:CGFloat(40+rand()%40), strokeColor: SKColor.greenColor(), backgroundColor: SKColor.whiteColor())
        }
    }
    
    
}
