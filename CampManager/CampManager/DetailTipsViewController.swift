//
//  DetailTipsViewController.swift
//  CampManager
//
//  Created by Jason Chan MBP on 6/20/16.
//  Copyright © 2016 Jason Chan. All rights reserved.
//

import UIKit

class DetailTipsViewController: UIViewController {

    
    @IBAction func backButtonDetailTips(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var moreInfoLabel: UILabel!
    
    var imageDetail = ""
    var descriptionDetail = ""
    var moreInfoDetail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailImage.image = UIImage(named: imageDetail)
        navigationItem.title = "test"
        moreInfoLabel.text = moreInfoDetail
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
