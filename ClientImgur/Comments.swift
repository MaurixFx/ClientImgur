//
//  Comments.swift
//  ClientImgur
//
//  Created by Mauricio Figueroa Olivares on 05-06-17.
//  Copyright © 2017 Mauricio Figueroa Olivares. All rights reserved.
//

import Foundation

class Comments: NSObject {
    
    // Propiedades
    var _id: Int!
    var _autor: String!
    var _comment: String!
    var _image_id: String
    
    var id: Int {
        
        return _id
    }
    
    var autor: String {
        return _autor
    }
    
    var comment: String {
        return _comment
    }
    
    var imageId: String {
        return _image_id
    }
    
    
    
    // Constructor de la clase
    init(id: Int, autor: String, comment: String, imageId: String) {
        self._id = id
        self._autor = autor
        self._comment = comment
        self._image_id = imageId
    }
    
    
}
