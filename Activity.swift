//
//  Activity.swift
//  NSA at ULM
//
//  Created by krsna on 3/31/15.
//  Copyright (c) 2015 Krnsa. All rights reserved.
//

import UIKit
import Foundation
class Activity: UIViewController,UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    var data = [PFObject]()
    var refreshControl = UIRefreshControl()
     required init(coder aDecoder: NSCoder){
        super.init(coder:aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        self.tableView.backgroundColor = UIColor .clearColor();
        self.refreshControl.addTarget(self, action: "Refresh", forControlEvents:UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }
    func Refresh()
    {
        self.viewDidLoad()
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
        
    }
    func loadData()
    {
        
        var feed:PFQuery = PFQuery(className: "feed")
        feed.findObjectsInBackgroundWithBlock { (objects:[AnyObject]!, error: NSError!) -> Void in
            if error == nil
            {
                self.data = objects.reverse() as [PFObject]
                self.tableView.reloadData()
            }
        }
        
        
    }
   func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
    }
    
    func tableView(tableView: UITableView?,numberOfRowsInSection section:Int) -> Int{
        return data.count
    }
    
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: AdditionalCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as AdditionalCell
        let d: PFObject = self.data[indexPath.row] as PFObject
        cell.Title?.text = d.objectForKey("Title") as? String
        //cell.created?.text = d.objectForKey("cDate") as? String
    //println(d)
    var dataFormatter:NSDateFormatter = NSDateFormatter()
    dataFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    cell.created.text = dataFormatter.stringFromDate(d.createdAt)
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
