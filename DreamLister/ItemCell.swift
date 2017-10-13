//
//  ItemCell.swift
//  DreamLister
//
//  Created by Ricardo Lousada on 08/10/17.
//  Copyright © 2017 IT-4-ALL. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

  
    @IBOutlet weak var thum: UIImageView!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var title: UILabel!
    
    func  configureCell(item: Item) {
        
        title.text = item.title
        price.text = "\(item.price)€"
        details.text = item.details
        thum.image = item.toImage?.image as? UIImage
    
    }
    
}
