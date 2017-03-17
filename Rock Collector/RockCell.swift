//
//  RockCell.swift
//  Rock Collector
//
//  Created by Anthony on 3/17/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

import UIKit

class RockCell: UITableViewCell {

    @IBOutlet weak var rockImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateCell(name:String, image:UIImage) {
        nameLabel.text = name
        rockImageView.image = image
    }
}
