//
//  TopicImagesCell.swift
//  ClientImgur
//
//  Created by Mauricio Figueroa Olivares on 03-06-17.
//  Copyright © 2017 Mauricio Figueroa Olivares. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class TopicImagesCell: UITableViewCell {

    
    @IBOutlet var imageViewPost: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    
    // Declaramos una variable de la clase Pokemon
    var topicPost: TopicPosts!
    var imagePost: ImagePost!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(_ topicPost: TopicPosts) {
        
         Manager.sharedInstance.imagesTopics(idAlbum: topicPost.id) { 
            
            self.imagePost = Manager.sharedInstance.imagePost
            
            if self.imagePost != nil {
                self.descriptionLabel.text = self.imagePost.descripcion
                self.imageViewPost.sd_setImage(with: URL(string: self.imagePost.link), placeholderImage: #imageLiteral(resourceName: "imgPlaceholder"), options: [.continueInBackground, .progressiveDownload])
            }  
            
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
