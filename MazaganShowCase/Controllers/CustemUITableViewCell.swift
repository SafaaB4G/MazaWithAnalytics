//
//  CustemUITableViewCell.swift
//  MazaganShowCase
//
//  Created by Nabil Sossey Alaoui on 5/18/17.
//  Copyright © 2017 B4E. All rights reserved.
//

import UIKit

class CustemUITableViewCell: UITableViewCell {

    
    @IBOutlet var imageCell: UIImageView!
   
    @IBOutlet var label: UILabel!
//    let frameLabel : CGSize = CGSize(width : 100,height : 100)
//    
//    let frameimage : CGSize = CGSize(width: 100, height: 100)

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
print("selected item in custem")
    
    }
    
}
