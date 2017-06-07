//
//  NewPostImageView.swift
//  ClientImgur
//
//  Created by Mauricio Figueroa Olivares on 05-06-17.
//  Copyright © 2017 Mauricio Figueroa Olivares. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON

class NewPostImageView: UIViewController {

    
    @IBOutlet var imagePost: UIImageView!
    @IBOutlet var titleTextfield: UITextField!
    @IBOutlet var textViewDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

        // Llamamos la función para configurar la imagen
        self.configImage()
        
    }
    
    func configImage() {
        // Creamos un gestureRecognizer
        let takePictureGesture = UITapGestureRecognizer(target: self, action: #selector(takePictureTap))
        
        // Lo añadimos a la imagen para que cuando se toque la foto se tome como una accion
        self.imagePost.addGestureRecognizer(takePictureGesture)
        
        // Habilitamos la interacción del usuario con la imagen
        self.imagePost.isUserInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func publish(_ sender: UIButton) {
        
        if self.imagePost.image == #imageLiteral(resourceName: "imgPlaceholder") {
            
            // Mostramos el Mensaje de alerta
            self.showAlert(title: "Publicación Imagen", message: "Debe seleccionar una imagen")
            
            return
        }
        
        // Llamamos la funcion para subir la Imagen
        Manager.sharedInstance.uploadImagen(image: self.imagePost.image!) {
            
            let link = Manager.sharedInstance.linkUploadedImage
            
            // Mostramos el Mensaje de exito
            self.showAlert(title: "Imagen Publicada", message: "La imagen ha sido publicada correctamente: \n link: \(link)")
            
            // Dejamos la imagen por defecto
            self.imagePost.image = #imageLiteral(resourceName: "imgPlaceholder")
            
        }
        
      
        
        
      
        
        
        
        
        
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
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

// Extendemos la clase para implementar los delegados
extension NewPostImageView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Funcion para cuando el usuario toque el gestureRecognizer que tiene la imagen
    func takePictureTap() {
        
        // Si la camara esta habilitada
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            // llamamos al metodo para menu de la camara
            showPhotoMenu()
        } else {
            // No tenemos la camara, obtenemos de la libreria
            choosePhotoFromLibrary()
        }
        
        
    }
    
    // Metodo para Menu de la camara
    func showPhotoMenu() {
        
        // Implementamos la alerta
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Implementamos la accion de cancelar
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        // Asignamos la accion de cancelar a nuestro alertController
        alertController.addAction(cancelAction)
        
        // Implementamos la accion de tomar foto
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default) { (_) in
            // Llamamos al metodo que toma la foto
            self.takePhotoWithCamera()
        }
        
        // Añadimos la accion de tomar foto a la alerta
        alertController.addAction(takePhotoAction)
        
        // Implementamos la accion para tomar la foto desde la libreria
        let chooseFromLibraryAction = UIAlertAction(title: "Elegir de la Libreria", style: .default) { (_) in
            
            // Llamamos a la funcion que obtiene la foto de la libreria
            self.choosePhotoFromLibrary()
        }
        
        // Añadimos la accion de elegir foto de la libreria a nuestra alerta
        alertController.addAction(chooseFromLibraryAction)
        
        // Presentamos la alerta en pantalla
        present(alertController, animated: true, completion: nil)
    }
    
    // Funcion para tomar foto desde la Camara
    func takePhotoWithCamera() {
        
        // Inicializamos el picker
        let imagePicker = UIImagePickerController()
        
        // Le asignamos la fuente de la camara
        imagePicker.sourceType = .camera
        
        // Le asignamos el delegado
        imagePicker.delegate = self
        
        // Le asignamos que si se pueda editar
        imagePicker.allowsEditing = true
        
        // Presentamos el picker en pantalla
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    // Funcion para obtener la foto desde la libreria
    func choosePhotoFromLibrary() {
        
        
        // Inicializamos el picker
        let imagePicker = UIImagePickerController()
        
        // Le asignamos la fuente de la libreria
        imagePicker.sourceType = .photoLibrary
        
        // Le asignamos el delegado
        imagePicker.delegate = self
        
        // Le asignamos que si se pueda editar
        imagePicker.allowsEditing = true
        
        // Presentamos el picker en pantalla
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    // Funcion para cuando se toma la foto
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Obtenemos la foto sacada y la transformamos en imagen
        let imageTaken = info[UIImagePickerControllerEditedImage] as? UIImage
        
        // Le asignamos la foto sacada por la camara a la imagen de la pantalla
        self.imagePost.image = imageTaken
        
        // Como ya tenemos una imagen, Habilitamos el boton Save
        //publishButton.isEnabled = true
        
        // Volvemos atras
        dismiss(animated: true, completion: nil)
    }
    
    // Funcion para cuando se cancele
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

