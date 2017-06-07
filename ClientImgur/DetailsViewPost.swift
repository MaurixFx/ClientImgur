//
//  DetailsViewPost.swift
//  ClientImgur
//
//  Created by Mauricio Figueroa Olivares on 04-06-17.
//  Copyright © 2017 Mauricio Figueroa Olivares. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class DetailsViewPost: UIViewController {

    @IBOutlet var imageViewPost: UIImageView!
    @IBOutlet var likeLabel: UILabel!
    @IBOutlet var noLikeLabel: UILabel!
    @IBOutlet var viewsLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    
    // Instanciamos nuestra clase Manager
    let instance = Manager()
    
    // Declaramos una objeto de tipo Topics
    // Donde recibimos el seleccionada en la pantalla anterior
    var postTopic : [TopicPosts] = []
    
    // Declaramos un array de la clase Comments
    var postComments : [Comments] = []
    
    
    var topicPost: TopicPosts!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

        // Nos hacemos delegados de la Manager con su protocolo
        instance.delegate = self as ManagerProtocol
        
        // Asignamos los valores al Post
        self.loadPost()
        
        // Cargamos los comentarios del Post
        self.loadCommentPost()
    }
    
    func loadCommentPost() {
        if self.postTopic.count > 0 {
            
            for post in self.postTopic {
                
                // Obtenemos los comentarios del Post
                Manager.sharedInstance.loadCommentsImage(idPost: post.id, completed: { 
                    // Asignamos el resultado del arreglo de comments
                    self.postComments = Manager.sharedInstance.comments
                    // Recargamos la tabla
                    self.tableView.reloadData()
                })
            }
        }

    }
    
    
    func loadPost() {
        if self.postTopic.count > 0 {
            for post in self.postTopic {
                // Asignamos el titulo
                self.title = post.title
                
                Manager.sharedInstance.loadPost(post: post, completed: {
                    // Asignamos el resultado del arreglo de imageTopic
                    self.topicPost = Manager.sharedInstance.topicPost
                    
                    // Asignamos los valores
                    self.imageViewPost.sd_setImage(with: URL(string: self.topicPost.link), placeholderImage: #imageLiteral(resourceName: "imgPlaceholder"), options: [.continueInBackground, .progressiveDownload])
                    
                    self.descriptionLabel.text = self.topicPost.descripcion
                    self.likeLabel.text = "\(self.topicPost.ups)"
                    self.noLikeLabel.text = "\(self.topicPost.downs)"
                    self.viewsLabel.text = "\(self.topicPost.views)"
                    
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// Implementamos el protocolo de la clase Manager
extension DetailsViewPost: ManagerProtocol {
    func loadPostTopic() {
    }
    
    func loadPostComment(){
        self.postComments = instance.comments;
        self.tableView.reloadData()
    }
    
    // Funcion donde Cargamos los Topic y recargamos la tabla
    func loadTable (){
    }
}

// Extendemos la clase para heredar funciones de la TableViewDatasource y TableViewDelegate
extension DetailsViewPost: UITableViewDataSource, UITableViewDelegate {
    
    // Funcion de número de secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Funcion de número filas en seccion
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      return self.postComments.count
    }
    
    // Función para configurar la celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let postComment : Comments!
        
        // Declaramos la celda de tipo con el id TopicImagesCell que es de tipo de la clase TopicCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! DetailsPostCell
        
        postComment = self.postComments[indexPath.row] // Obtenemos la fila
        
        cell.userLabel.text = postComment.autor
        cell.commentLabel.text = postComment.comment
        
        return cell
        
    }
    
    // Funcion de selección de la celda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Deseleccionamos la celda
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}

