//
//  ViewController.swift
//  IOSTrainingApp
//
//  Created by Omar Bizreh on 2/6/16.
//  Copyright © 2016 Omar Bizreh. All rights reserved.
//

import UIKit
import KYDrawerController

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var viewHeader: UIView!
    private let cellIdentifier = "reuseCell"
    private let headersArray: [String] = ["Controls", "General"]
    private var drawerView: KYDrawerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.viewHeader.backgroundColor = UIColor(patternImage: UIImage(named: "header_image.jpg")!)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        self.drawerView = (UIApplication.sharedApplication().windows[0].rootViewController as! KYDrawerController)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }else{
            return 2
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier)
        if indexPath.section == 0 {
            cell?.textLabel?.text = "Hellow World"
        }
        else{
            cell?.textLabel?.text = "Hello World"
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.drawerView?.setDrawerState(.Closed, animated: true)
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.headersArray[section]
    }
    
}

