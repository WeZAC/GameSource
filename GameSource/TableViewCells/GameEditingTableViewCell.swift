//
//  GameDetailsTableViewCell.swift
//  GameSource
//
//  Created by Langtian Qin on 5/5/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit
import TagListView

class GameEditingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var mainDevImageView: UIImageView!
    
    @IBOutlet weak var mainDevLabel: UILabel!
    @IBOutlet weak var descView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

