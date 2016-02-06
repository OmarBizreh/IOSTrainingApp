//
//  MainTableViewController.swift
//  IOSTrainingApp
//
//  Created by Omar Bizreh on 2/6/16.
//  Copyright © 2016 Omar Bizreh. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController {

    var Names: [String] = [String]()
    var people: [NSManagedObject] = [NSManagedObject]()
    let cellIdentifier = "reuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let btnRefresh = UIBarButtonItem(title: "Refresh", style: UIBarButtonItemStyle.Plain, target: self, action: "loadData")
        self.navigationItem.rightBarButtonItem = btnRefresh
        let btnAdd = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Done, target: self, action: "AddName")
        self.navigationItem.leftBarButtonItem = btnAdd
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func loadData(){
        self.fetchPersons()
    }
    
    func AddName(){
        let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .Alert)
        let saveAction = UIAlertAction(title: "Save", style: .Default, handler: {(action: UIAlertAction) -> Void in
            let textField = alert.textFields!.first
            // self.Names.append(textField!.text!)
            self.saveName(textField!.text!)
            self.tableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            
        }
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        alert.addTextFieldWithConfigurationHandler { (txt:UITextField) -> Void in
            
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func saveName(name: String){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let mPersonEntity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)
        let mPerson = NSManagedObject(entity: mPersonEntity!, insertIntoManagedObjectContext: managedContext)
        mPerson.setValue(name, forKey: "name")
        
        do{
            try managedContext.save()
            self.people.append(mPerson)
        }catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func fetchPersons(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        do{
            let results = try managedContext.executeFetchRequest(fetchRequest)
            self.people = results as! [NSManagedObject]
            self.tableView.reloadData()
        }catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.people.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier, forIndexPath: indexPath)

        //cell.textLabel?.text = self.Names[indexPath.row]

        cell.textLabel?.text = self.people[indexPath.row].valueForKey("name") as? String
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
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

    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
