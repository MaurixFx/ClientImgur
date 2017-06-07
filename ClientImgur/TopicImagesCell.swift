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
            
            self.titleLabel.text = topicPost.title
            self.descriptionLabel.text = self.imagePost.descripcion
            self.imageViewPost.sd_setImage(with: URL(string: self.imagePost.link), placeholderImage: #imageLiteral(resourceName: "imgPlaceholder"), options: [.continueInBackground, .progressiveDownload])
            
            
        }
        
    }
    
    // Funcion donde configuramos la celda
  /*  func configureCell(_ topicPost: TopicPosts) {
        self.topicPost = topicPost
        
        // Declaramos la Url para la petición
        let urlPost = "\(CbaseUrlAlbumImage)\(self.topicPost.id)/images"
        print(urlPost)
        Alamofire.request(urlPost, method: .get, parameters: nil, encoding: URLEncoding.default, headers: Cheaders).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(let data):
                let json = JSON(data);
                let sucess = json["success"].int;
                
                // Si se tiene exito
                if (sucess == 1){
                    let dataPost =  json["data"];
                    
                    //Limpiamos el Array
                   // self.imagesTopic.removeAll();
                    
                    for t in 0..<dataPost.count{
                        
                        // Solo asignamos la primera imagen, en caso que fueran mas
                        if t == 0 {
                            
                            //Parse Array from Json Response
                            let subArrayPost = dataPost[t];
                            //let description = subArrayPost["description"].string
                            /*let start = link?.startIndex
                             let end = link?.index((link?.endIndex)!, offsetBy: -3)
                             let substring = link?[start!..<end!] // www.stackoverflow*/
                            
                            let type = subArrayPost["type"].string
                            
                            // Si es una imagen la procesamos
                            if type == "image/jpeg" {
                                let id =  subArrayPost["id"].string!
                                let link =  subArrayPost["link"].string!
                                let descripcion =  subArrayPost["description"].string
                                
                                print(link)
                                
                                // Asignamos el titulo
                                self.titleLabel.text = self.topicPost.title
                                
                                // Si no hay descripción lo dejamos vacio
                                if let descriptionPost =  descripcion {
                                    self.descriptionLabel.text = descriptionPost
                                } else {
                                    self.descriptionLabel.text = ""
                                }
                                
                                // Asignamos la imagen a la celda
                                self.imageViewPost.sd_setImage(with: URL(string: link), placeholderImage: #imageLiteral(resourceName: "imgPlaceholder"), options: [.continueInBackground, .progressiveDownload])
                                
                                /*
                                 DispatchQueue.global().async {
                                 let urlImage = URL(string: link)
                                 let data = try? Data(contentsOf: urlImage!)
                                 DispatchQueue.main.async {
                                 self.imageViewPost.image = UIImage(data: data!)
                                 }
                                 }*/
                            }
                        }
               
                    }
                    
                    
                }else{
                    print ("Error de acceso");
                    
                }
                
            case .failure(let error):
                print("\(error.localizedDescription)")
                break
                
            }
        }
        
    }*/

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
