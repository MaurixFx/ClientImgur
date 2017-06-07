//
//  TopicsView
//  ClientImgur
//
//  Created by Mauricio Figueroa Olivares on 31-05-17.
//  Copyright © 2017 Mauricio Figueroa Olivares. All rights reserved.
//

import UIKit

class TopicsView: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    // Instanciamos nuestra clase Manager
    let instance = Manager()
    
    var categorys : [Tags] = []
    
    // Declaramos un arreglo vacio donde mostraremos los resultados de la busqueda
    var searchResult: [Tags] = []
    
    // Declaramos nuestra barra de busqueda
    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        
        // Creamos nuestra barra de busqueda
        self.createSearchController()
        
        // Nos hacemos delegados de la Manager con su protocolo
        instance.delegate = self as ManagerProtocol
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.title = "Imgur"
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "showImagesTopic" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow { // Asignamos la fila seleccionada a la variable
                
                let selectedTopic : Tags!
                
                // Si la barra de busqueda esta activa
                // Asignamos la fila del resultado de la busqueda
                if self.searchController.isActive {
                    selectedTopic = self.searchResult[indexPath.row]
                    self.searchController.isActive = false
                }else {
                    selectedTopic = self.categorys[indexPath.row] // Obtenemos la fila
                    
                }
                
                self.navigationItem.title = nil
                
            
                let imagesTopicView = segue.destination as! TopicImagesView  // Asignamos de manera fija que el destino del segue, es decir la transicion sea a la pantalla
                
                
                imagesTopicView.tag = selectedTopic // Asignamos el topic seleccionado a la pantalla siguiente de imagenes del Topic

                
            }

            
            
        }
        
    }
    
    
}

// Implementamos el protocolo de la clase Manager
extension TopicsView: ManagerProtocol {
    func loadPostTopic() {
    }
    
    func loadPostComment(){
    }

    // Funcion donde Cargamos los Topic y recargamos la tabla
    func loadTable (){
        self.categorys = instance.tags;
        self.tableView.reloadData()
    }
}


// Extendemos la clase para heredar funciones de la TableViewDatasource y TableViewDelegate
extension TopicsView: UITableViewDataSource, UITableViewDelegate {
    
    // Funcion de número de secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     // Funcion de número filas en seccion
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Si estamos en modo de busqueda
        // Devolvemos la cantidad recuperada por el filtro
        // Si no devuelve el total de filas
        if self.searchController.isActive  {
            return self.searchResult.count
        } else {
            return self.categorys.count
        }
    }
    
    // Función para configurar la celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let topic : Tags!
        
        // Declaramos la celda de tipo con el id TopicCell que es de tipo de la clase TopicCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell") as! TopicsCell
    
        // Si estamos en modo de busqueda
        // Asignamos la fila del resultado de la busqueda
        if self.searchController.isActive  {
            topic = self.searchResult[indexPath.row]
        }else {
            topic = self.categorys[indexPath.row] // Obtenemos la fila
        }
        
        //Agregamos el accesoryType a la celda
        cell.accessoryType = .disclosureIndicator
        
        // Asignamos el nombre del Topic al Label de la celda
        cell.categoryNameLabel.text = topic.displayName
        
        return cell
        
    }
    
    // Funcion de selección de la celda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Deseleccionamos la celda
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

//Implementamos La extension para poder actualizar el valor de lo que buscamos
extension TopicsView : UISearchResultsUpdating {
    
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
        self.searchResult = self.categorys.filter({ (topic) -> Bool in
            
            // Buscamos el texto ingresado en la barra de busqueda dentro del array de lugares
            let nameToFind = topic.name.range(of: textToSearch, options: NSString.CompareOptions.caseInsensitive)
            
            // Retornamos la busqueda
            return nameToFind != nil
        })
        
    }
    
    
    
}







