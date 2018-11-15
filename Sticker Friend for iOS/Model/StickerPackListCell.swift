//
//  StickerPackListCell.swift
//  Sticker Friend for iOS
//
//  Created by João Leite on 13/11/18.
//  Copyright © 2018 João Leite. All rights reserved.
//

import UIKit

class StickerPackListCell: UITableViewCell {

    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtAuthor: UILabel!
    @IBOutlet weak var imgSticker1: UIImageView!
    @IBOutlet weak var imgSticker2: UIImageView!
    @IBOutlet weak var imgSticker3: UIImageView!
    @IBOutlet weak var imgSticker4: UIImageView!
    @IBOutlet weak var imgSticker5: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
