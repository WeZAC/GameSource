//
//  GameDetailsTableViewCell.swift
//  GameSource
//
//  Created by Langtian Qin on 5/5/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit
import TagListView

class GameDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainDevImageView: UIImageView!
    @IBOutlet weak var mainDevLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet var mainTagView: TagListView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainTagView.addTag("Card Game")
        mainTagView.addTag("Strategy")
        mainTagView.addTag("Collection")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
