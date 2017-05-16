//
//  MyCell.swift
//  MazaganShowCase
//
//  Created by Nabil Sossey Alaoui on 4/3/17.
//  Copyright © 2017 B4E. All rights reserved.
//

import Foundation
import UIKit

class MyCell : UITableViewCell{
    
    //Do whatever you want as exta customization
    
    
    func setUpCell() {
        var itemLabel = UILabel(frame: CGRect(x :0,  y: 0, width: 200, height : 30))
        
        var frame: CGRect  = CGRect(x :0,  y: 0, width: 200, height : 50)
        
        let Image : UIImageView ?
        Image!.frame = frame
        self.addSubview(Image)
        self.addSubview(itemLabel)

    }
    
    
}
