//
//  DoubleLabelTableViewCell.swift
//  GameSource
//
//  Created by Langtian Qin on 5/5/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit

class DoubleLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
