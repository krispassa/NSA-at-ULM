//
//  infoViewController.swift
//  NSA at ULM
//
//  Created by krsna on 4/3/15.
//  Copyright (c) 2015 Krnsa. All rights reserved.
//

import UIKit

class infoViewController: UIViewController, UITableViewDelegate{

  
    @IBOutlet weak var tView: UITableView!
    
    
    var query = [PFObject]()
    var refreshControl = UIRefreshControl()
    required init(coder aDecoder: NSCoder){
        super.init(coder:aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetch()
        self.tView.backgroundColor = UIColor .clearColor();
        self.refreshControl.addTarget(self, action: "Refresh", forControlEvents:UIControlEvents.ValueChanged)
        self.tView.addSubview(refreshControl)
    }
    func Refresh()
    {
        self.viewDidLoad()
        self.tView.reloadData()
        self.refreshControl.endRefreshing()
        
    }
    // calling data from parse.com
    func fetch()
    {
        
        var load:PFQuery = PFQuery(className: "info")
        load.addAscendingOrder("createdAt")
        load.cachePolicy = PFCachePolicy.NetworkElseCache
        load.findObjectsInBackgroundWithBlock { (objects:[AnyObject]!, error: NSError!) -> Void in
            if error == nil
            {
                self.query = objects as [PFObject]
                self.tView.reloadData()
                // println(objects)
            }
        }
        
        
    }
    // func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    //return 1
    //}
    
    func tableView(tableView: UITableView?,numberOfRowsInSection section:Int) -> Int{
        return query.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: infoTableViewCell = tableView.dequeueReusableCellWithIdentifier("AddCell", forIndexPath: indexPath) as infoTableViewCell
        let e: PFObject = self.query[indexPath.row] as PFObject
        cell.name.text = e.objectForKey("Name") as? String
        cell.position.text = e.objectForKey("Position") as? String
        cell.email.text = e.objectForKey("email") as? String
        cell.phone.text = e.objectForKey("phone") as? String
        
        
        return cell
    }
}
