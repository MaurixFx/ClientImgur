//
//  DetailsPostCell.swift
//  ClientImgur
//
//  Created by Mauricio Figueroa Olivares on 04-06-17.
//  Copyright © 2017 Mauricio Figueroa Olivares. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class DetailsPostCell: UITableViewCell {

    
    @IBOutlet var userLabel: UILabel!
    @IBOutlet var commentLabel: UILabel!

    // Declaramos una variable de la clase Pokemon
    var topicPost: TopicPosts!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
