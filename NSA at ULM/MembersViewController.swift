//
//  MembersViewController.swift
//  NSA at ULM
//
//  Created by krsna on 4/2/15.
//  Copyright (c) 2015 Krnsa. All rights reserved.
//

import UIKit

class MembersViewController: UIViewController, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    var dta = [PFObject]()
    var refreshControl = UIRefreshControl()
    required init(coder aDecoder: NSCoder){
        super.init(coder:aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingData()
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
    func loadingData()
    {
        
        var load:PFQuery = PFQuery(className: "officers")
        load.addAscendingOrder("createdAt")
        load.cachePolicy = PFCachePolicy.NetworkElseCache
        load.findObjectsInBackgroundWithBlock { (objects:[AnyObject]!, error: NSError!) -> Void in
            if error == nil
            {
                self.dta = objects as [PFObject]
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    func tableView(tableView: UITableView?,numberOfRowsInSection section:Int) -> Int{
        return dta.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: MembersIndoTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as MembersIndoTableViewCell
        let e: PFObject = self.dta[indexPath.row] as PFObject
        cell.Name.text = e.objectForKey("Name") as? String
        cell.Position.text = e.objectForKey("Position") as? String
        
        let _image:PFFile = e["img"] as PFFile
        _image.getDataInBackgroundWithBlock { (image_Data: NSData!, error:NSError!) -> Void in
            if error == nil
            {
                let pic:UIImage = UIImage(data: image_Data)!
                cell.imgView.image = pic
            }
        }
    return cell
}
}