//
//  DUQuarterCell.swift
//  DataUsage
//
//  Created by Suri,Sai Sailesh Kumar on 21/10/19.
//  Copyright © 2019 Sailesh. All rights reserved.
//

import UIKit

class DUQuarterCell: UITableViewCell {

    @IBOutlet weak var lblDataVolume: UILabel!
    @IBOutlet weak var lblQuarter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
