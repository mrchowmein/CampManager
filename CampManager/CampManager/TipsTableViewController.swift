//
//  TipsTableViewController.swift
//  CampManager
//
//  Created by Jason Chan MBP on 6/20/16.
//  Copyright © 2016 Jason Chan. All rights reserved.
//

import UIKit

class TipsTableViewController: UITableViewController {

    
    @IBAction func backButton(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    var tipsArray:[Tips] = [Tips]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tips1 = Tips(imageName: "weapons.jpg", description: "Weapons", moreInfo: "Crossbow, Molotov Cocktails, Pistol, Rifle, Baseball Bat, Screwdriver, Machete, Construction Tools")
        let tips2 = Tips(imageName: "food.jpg", description: "Food Source", moreInfo: "Canned Food, Hunting, Scavenging, Dehydrated Camp Food, Pharmacies, Grocery Stores, Gas Stations, Prison, Schools")
        let tips3 = Tips(imageName: "shelter.jpg", description: "Shelter Options", moreInfo: "Prison, Schools, Abandon Homes, Warehouses, Houseboats, Tents, Recreation Vehicles")
        let tips4 = Tips(imageName: "fight.jpg", description: "Combat Skills", moreInfo: "Always aim for a headshot. Use bludgeon and bladed weapons. Hold the undead by the neck")
        
        tipsArray.append(tips1)
        tipsArray.append(tips2)
        tipsArray.append(tips3)
        tipsArray.append(tips4)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tipsArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TipsCell", forIndexPath: indexPath) as! TipsCell

        let tipItem = tipsArray[indexPath.row]
        
        cell.tipsImage.image = UIImage(named: tipItem.imageName)
        cell.tipsLabel.text = tipItem.description

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let tipSelected = tipsArray[indexPath.row]
        let detailVC:DetailTipsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailTipsViewController") as! DetailTipsViewController
        
        detailVC.imageDetail = tipSelected.imageName
        detailVC.descriptionDetail = tipSelected.description
        detailVC.moreInfoDetail = tipSelected.moreInfo
        
        self.presentViewController(detailVC, animated: true, completion: nil)
    }
    



}
