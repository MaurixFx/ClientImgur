//
//  Manager.swift
//  ClientImgur
//
//  Created by Mauricio Figueroa Olivares on 03-06-17.
//  Copyright © 2017 Mauricio Figueroa Olivares. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol ManagerProtocol: class {
    func loadTable()
    func loadPostTopic()
    func loadPostComment()
}

class Manager: NSObject {
    
    // Instancia compartida
    static let sharedInstance = Manager()
    
    // Declaramos un array de la clase Topics
    var tags : [Tags] = []
    
    // Declaramos un array de la clase Topics
    var imagesTopic : [TopicPosts] = []
    
    // Declaramos un array de la clase Comments
    var comments : [Comments] = []
    
    // Declaramos un objeto de la clase ImagePost
    var imagePost: ImagePost!
    
    // Declaramos un objeto de la clase TopicPosts
    var topicPost: TopicPosts!
    
    weak var delegate: ManagerProtocol?

    var linkUploadedImage: String = ""
    
    override init() {
        super.init()
        
        //Llamamos la funcion de carga de topics
        self.loadTopics()
    }
    
    func loadTopics() {

        Alamofire.request(CbaseUrlTags, method: .get, parameters: nil, encoding: URLEncoding.default, headers: Cheaders).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(let data):
                let json = JSON(data);
                let sucess = json["success"].int;
                
                if (sucess == 1){

                    let dataJSON = json["data"];
                    
                    //Limpiamos el Array
                    self.tags.removeAll();
                    
                    for result in dataJSON["tags"].arrayValue {
                        let name = result["name"].string
                        let displayName = result["display_name"].string

                        // Instanciamos la clase Tags y le pasamos los parametros obtenidos
                        let myTag = Tags(name: name!, displayName: displayName!)
                        
                        //Agregamos el topic a nuestro array
                        self.tags.append(myTag)
                    }

                    // Ejecutamos la funcion del protocolo
                    self.delegate?.loadTable()

                    
                }else{
                    print ("Error to Access");
                    
                }
                
            case .failure(let error):
                print("\(error.localizedDescription)")
                break
                
            }
        }
        
    }
    
    func loadTopicsPost(nameTag: String, completed: @escaping DownloadComplete) {
        
        // Agregamos la id del topic a la URL
        let url = "\(CbaseUrlGaleryTags)\(nameTag)/"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: Cheaders).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(let data):
                let json = JSON(data);
                let sucess = json["success"].int;
                
                // Si se tiene exito
                if (sucess == 1){
                    let dataJSON =  json["data"];
                    
                    //Limpiamos el Array
                    self.imagesTopic.removeAll();
                    
                    
                    for result in dataJSON["items"].arrayValue {
                        let idAlbum = result["id"].string
                        let title = result["title"].string
                        let datetime = result["datetime"].number
                        let views = result["views"].int
                        let ups = result["ups"].int
                        let downs = result["downs"].int
                        
                        // Instanciamos la clase Topics y le pasamos los parametros
                        let myGalerryTag = TopicPosts(id: idAlbum!, title: title!, description: "", datetime: datetime!, views: views!, link: "", ups: ups!, downs: downs!)
                        
                        //Agregamos el topic a nuestro array
                        self.imagesTopic.append(myGalerryTag)
                        
                    }
                    
                    // Cuando finaliza
                   completed()
                    
                }else{
                    print ("Error de acceso");
                    
                }
                
            case .failure(let error):
                print("\(error.localizedDescription)")
                break
                
            }
            
        }

       
    }
    
    func imagesTopics(idAlbum: String, completed: @escaping DownloadComplete) {
        
        // Declaramos la Url para la petición
        let urlPost = "\(CbaseUrlAlbumImage)\(idAlbum)/images"
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
                            let type = subArrayPost["type"].string
                            
                            // Si es una imagen la procesamos
                            if type == "image/jpeg" || type == "image/gif"  {
                                var descrip: String = ""
                                let link =  subArrayPost["link"].string!
                                let descripcion =  subArrayPost["description"].string
                                
                                print(link)

                                // Si no hay descripción lo dejamos vacio
                                if let descriptionPost =  descripcion {
                                    descrip = descriptionPost
                                } else {
                                    descrip = ""
                                }
                                
                                let myImagePost = ImagePost(idAlbum: idAlbum, descripcion: descrip, link: link)
                                
                                // Asignamos el objeto
                                self.imagePost = myImagePost
                                
                         
                            }
                        }
                        
                    }
                    
                    // Cuando finaliza
                    completed()
                    
                    
                }else{
                    print ("Error de acceso");
                    
                }
                
            case .failure(let error):
                print("\(error.localizedDescription)")
                break
                
            }
        }

    }
    
    
    func loadPost(post: TopicPosts, completed: @escaping DownloadComplete) {
        
        // Declaramos la Url para la petición
        let urlPost = "\(CbaseUrlAlbumImage)\(post.id)/images"
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
                    self.imagesTopic.removeAll();
                    
                    for t in 0..<dataPost.count{
                        
                        // Solo asignamos la primera imagen, en caso que fueran mas
                        if t == 0 {
                            
                            //Parse Array from Json Response
                            let subArrayPost = dataPost[t];
                            let type = subArrayPost["type"].string
                            
                            // Si es una imagen la procesamos
                            if type == "image/jpeg" || type == "image/gif"  {
                                let link =  subArrayPost["link"].string!
                                let descripcion =  subArrayPost["description"].string
      
                                // Creamos el objeto con los valores
                                let myTopicPost = TopicPosts(id: post.id, title: post.title, description: descripcion, datetime: post.datetime, views: post.views, link: link, ups: post.ups, downs: post.downs)
                                
                                // Asignamos el valor del objeto
                                self.topicPost = myTopicPost
 
                            }
                        }
                        
                    }
                    
                    // Si ya finalizo la petición
                    completed()
                    
                    
                }else{
                    print ("Error de acceso");
                    
                }
                
            case .failure(let error):
                print("\(error.localizedDescription)")
                break
                
            }
        }
    }
    
    
    func loadCommentsImage(idPost: String, completed: @escaping DownloadComplete) {
        
        // Agregamos la id del topic a la URL
        let url = "\(CbaseUrlCommentsGalleryImage)\(idPost)/comments/"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: Cheaders).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(let data):
                let json = JSON(data);
                let sucess = json["success"].int;
                
                // Si se tiene exito
                if (sucess == 1){
                    
                    let data =  json["data"];
                    
                    //Limpiamos el Array
                    self.comments.removeAll();
                    
                    
                    for i in 0..<data.count{
                        
                        //Parse Array from Json Response
                        let subArray = data[i];
                        let id = subArray["id"].int
                        let autor = subArray["author"].string
                        let comment = subArray["comment"].string
                        let image_id = subArray["image_id"].string
                        
                        
                        // Instanciamos la clase Topics y le pasamos los parametros
                        let myComment = Comments(id: id!, autor: autor!, comment: comment!, imageId: image_id!)
                        
                        //Agregamos el topic a nuestro array
                        self.comments.append(myComment)
                        
                    }
                    
                    // Si ya finalizo la petición
                    completed()
                    
                }else{
                    print ("Error de acceso");
                    
                }
                
            case .failure(let error):
                print("\(error.localizedDescription)")
                break
                
            }
            
        }

    }


    func uploadImagen(image: UIImage, completed: @escaping DownloadComplete){
        
        let imageData = UIImagePNGRepresentation(image)
        let base64Image = imageData?.base64EncodedString(options: .lineLength64Characters)
        
        let parameters = [
            "image": base64Image
        ]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            if let imageData = UIImageJPEGRepresentation(image, 1) {
                multipartFormData.append(imageData, withName: "maurixfd", fileName: "maurixfd.png", mimeType: "image/png")
            }
            
            for (key, value) in parameters {
                multipartFormData.append((value?.data(using: .utf8))!, withName: key)
            }}, to: CbaseUrlUploadImage, method: .post, headers: Cheaders,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.response { response in
                            //This is what you have been missing
                            let json = try? JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [String:Any]
                            print(json!)
                            let imageDic = json?["data"] as? [String:Any]
                            print(imageDic!["link"]!)
                            
                             self.linkUploadedImage = (imageDic!["link"]! as? String)!
                            
                          completed()
  
                        }
                    case .failure(let encodingError):
                        print("error:\(encodingError)")
                    }
        })
        
    }
}
