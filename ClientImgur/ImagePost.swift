//
//  ImagePost.swift
//  ClientImgur
//
//  Created by Mauricio Figueroa Olivares on 06-06-17.
//  Copyright © 2017 Mauricio Figueroa Olivares. All rights reserved.
//

import Foundation

class ImagePost: NSObject {
    
    // Propiedades
    var _idAlbum: String!
    var _descripcion: String!
    var _link: String!
    
    var idAlbum: String {
        
        return _idAlbum
    }
    
    var descripcion: String {
        return _descripcion
    }
    
    var link: String {
        return _link
    }
    
    // Constructor de la clase
    init(idAlbum: String, descripcion: String, link: String) {
        self._idAlbum = idAlbum
        self._descripcion = descripcion
        self._link = link
    }
    
    
}
