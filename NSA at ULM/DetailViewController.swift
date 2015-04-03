//
//  DetailViewController.swift
//  NSA at ULM
//
//  Created by krsna on 4/2/15.
//  Copyright (c) 2015 Krnsa. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    
    var Detail: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.backgroundColor = UIColor.clearColor()
        textView.textColor = UIColor.whiteColor()
        self.textView.text = Detail
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    


}
