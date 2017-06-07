//
//  TopicImagesView.swift
//  ClientImgur
//
//  Created by Mauricio Figueroa Olivares on 03-06-17.
//  Copyright © 2017 Mauricio Figueroa Olivares. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TopicImagesView: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
    
    // Declaramos una objeto de tipo Topics
    // Donde recibimos el seleccionada en la pantalla anterior
    var tag: Tags!
    
    // Declaramos un array de topicPosts
    var topicPost : [TopicPosts] = []
    
    // Declaramos nuestra barra de busqueda
    var searchController: UISearchController!
    
    // Creamos un array de los resultados de busqueda
    var searchResult = [TopicPosts]()
    
    // Declaramos un refreshControll
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuramos el navigationBar
        self.configureNavigationBar()

        // Asignamos el nombre del topic al titulo principal
        self.title = tag.name.capitalized
        
        // Creamos nuestra barra de busqueda
        self.createSearchController()
        
        self.createRefreshController()
        
        // Nos hacemos delegados de la Manager con su protocolo
        Manager.sharedInstance.delegate = self as ManagerProtocol
        
        // Cargamos Los Posts del Tag
        loadTopicPosts()
        
    }
    
    func createRefreshController() {
        // Creamos un refreshControl
        self.refreshControl = UIRefreshControl()
        
        // Asignamos un titulo al refresh
        self.refreshControl.attributedTitle = NSAttributedString(string: "Tira para recargar mas imagenes")
        //Agregamos la vista y el metodo cargar Usuarios
        self.refreshControl.addTarget(self, action: #selector(TopicImagesView.loadTopicPosts), for: .valueChanged)
        
        // Agregamos el refreshControl a la tabla
        self.tableView.refreshControl = self.refreshControl
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        // Eliminamos el boton Back
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         // Asignamos el nombre del topic al titulo principal
        self.navigationItem.title = tag.name
       
    }

    func createSearchController() {
        // Inicializamos la barra de busqueda y le indicamos nil ya que el resultado lo mostraremos en
        // este mismo viewController
        self.searchController = UISearchController(searchResultsController: nil)
        
        //Agregamos nuestra barra de busqueda en el header de nuestra tabla
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        // Le indicamos a la barra de busqueda que somos su delegado
        self.searchController.searchResultsUpdater = self
        
        // Ponemos la propiedad en false
        self.searchController.dimsBackgroundDuringPresentation = false
        
        // le asignamos un placeHolder a la barra de busqueda
        self.searchController.searchBar.placeholder = "Search"
        
        // Color del texto para la barra de busqueda busqueda
        self.searchController.searchBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        // Color de fondo de la barra de busqueda
        self.searchController.searchBar.barTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

    }
    
    func loadTopicPosts() {
        // Asignamos el id del topic que elegimos en la pantalla anterior
        let name = self.tag.name.capitalized
        
        // Cargamos los Post del Topic seleccionado en la pantalla anterior
      //  self.topicPost = Manager.sharedInstance.loadTopicsPost(nameTag: name)
        
        Manager.sharedInstance.loadTopicsPost(nameTag: name) { 
            // Asignamos el resultado de la peticion a nuestro array
            self.topicPost = Manager.sharedInstance.imagesTopic
            
            // Paramos el refreshControl
            self.refreshControl.endRefreshing()
            
            // Recargamos la tabla
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func newImage(_ sender: UIBarButtonItem) {
        
         performSegue(withIdentifier: "newImage", sender: self)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPost" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow { // Asignamos la fila seleccionada a la variable
                
                let selectedPost : TopicPosts!
                
                // Si la barra de busqueda esta activa
                // Asignamos la fila del resultado de la busqueda
                if self.searchController.isActive {
                    selectedPost = self.searchResult[indexPath.row]
                    self.searchController.isActive = false
                }else {
                    selectedPost = self.topicPost[indexPath.row] // Obtenemos la fila
                    
                }
                
                let detailPost = segue.destination as! DetailsViewPost  // Asignamos de manera fija que el destino del segue, es decir la transicion sea a la pantalla
                
                self.navigationItem.title = nil
                
                var array : [TopicPosts] = []
                array.append(selectedPost)
                
                detailPost.postTopic = array // Asignamos el topic seleccionado a la pantalla siguiente de imagenes del Topic
                
                
            }
            
            
            
        } else if segue.identifier == "newImage" {
            
            _ = segue.destination as! NewPostImageView  // Asignamos de manera fija que el destino del segue, es decir la transicion sea a la pantalla
            self.navigationItem.title = nil
            
        }

    }
    

}



// Implementamos el protocolo de la clase Manager
extension TopicImagesView: ManagerProtocol {
    func loadPostTopic() {
        self.topicPost = Manager.sharedInstance.imagesTopic        
        self.tableView.reloadData()
    }
    
    // Funcion donde Cargamos los Topic y recargamos la tabla
    func loadTable (){
    }
    
    func loadPostComment(){
    }
}


// Extendemos la clase para heredar funciones de la TableViewDatasource y TableViewDelegate
extension TopicImagesView: UITableViewDataSource, UITableViewDelegate {
    
    // Funcion de número de secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Funcion de número filas en seccion
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Si estamos en modo busquedo asignamos la cantidad de resultados
        if self.searchController.isActive {
            return self.searchResult.count
        } else {
            return self.topicPost.count
        }
    }
    
    // Función para configurar la celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let post : TopicPosts!

        // Declaramos la celda de tipo con el id TopicImagesCell que es de tipo de la clase TopicCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicImageCell") as! TopicImagesCell
        

        // Si estamos en modo busquedo asignamos el objeto del array de resultados
        if self.searchController.isActive {
            post = self.searchResult[indexPath.row] // Obtenemos la fila
        } else {
            post = self.topicPost[indexPath.row] // Obtenemos la fila
        }
        
        // Asignamos el titulo
        cell.titleLabel.text = post.title.capitalized
        
        // Llamamos la función para configurar la imagen y descripcion celda
        cell.configureCell(post)

        return cell
        
    }
    
       // Funcion de selección de la celda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Deseleccionamos la celda
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }

}

//Implementamos La extension para poder actualizar el valor de lo que buscamos
extension TopicImagesView : UISearchResultsUpdating {
    
    // Se ejecuta cuando hay que actualizar el searchController
    func updateSearchResults(for searchController: UISearchController) {
        
        // Asignamos el texto ingresado en la searchBar
        if let searchText = searchController.searchBar.text {
            
            // Filtramos lo ingresado en la searchBar
            self.filterContentFor(textToSearch: searchText)
            
            // Recargamos la tabla
            self.tableView.reloadData()
            
        }
        
        
    }
    
    // Funcion de filtrado de la searchBar
    func filterContentFor(textToSearch: String) {
        
        // Realizamos el filtro
        self.searchResult = self.topicPost.filter({ (post) -> Bool in
            
            // Buscamos el texto ingresado en la barra de busqueda dentro del array de lugares
            let nameToFind = post.title.range(of: textToSearch, options: NSString.CompareOptions.caseInsensitive)
            
            // Retornamos la busqueda
            return nameToFind != nil
        })
        
    }
    
    
    
}

