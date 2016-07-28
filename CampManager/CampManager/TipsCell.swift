//
//  Tips.swift
//  CampManager
//
//  Created by Jason Chan MBP on 6/20/16.
//  Copyright © 2016 Jason Chan. All rights reserved.
//

import UIKit

class TipsCell: UITableViewCell {

    @IBOutlet weak var tipsLabel: UILabel!
    
    @IBOutlet weak var tipsImage: UIImageView!
    
    
    override func awakeFromNib() {
      
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
