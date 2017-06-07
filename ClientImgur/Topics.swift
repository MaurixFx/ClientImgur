//
//  Topics.swift
//  ClientImgur
//
//  Created by Mauricio Figueroa Olivares on 31-05-17.
//  Copyright © 2017 Mauricio Figueroa Olivares. All rights reserved.
//

import Foundation

class Topics: NSObject {
    
    // Propiedades
    var _id: Int!
    var _name: String!
    
    var id: Int {
        
        return _id
    }
    
    var name: String {
        return _name
    }
    
    // Constructor de la clase
    init(id: Int, name: String) {
        self._id = id
        self._name = name
    }
    
    
}
