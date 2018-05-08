//
//  SingleLabelTableViewCell.swift
//  GameSource
//
//  Created by Langtian Qin on 5/5/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit

class SingleLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var singleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
