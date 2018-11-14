//
//  StickerCell.swift
//  Sticker Friend for iOS
//
//  Created by João Leite on 13/11/18.
//  Copyright © 2018 João Leite. All rights reserved.
//

import UIKit

class StickerCell: UITableViewCell {

    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtAuthor: UILabel!
    @IBOutlet weak var imgSticker1: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
