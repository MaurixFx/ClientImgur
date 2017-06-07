//
//  Tags.swift
//  ClientImgur
//
//  Created by Mauricio Figueroa Olivares on 04-06-17.
//  Copyright © 2017 Mauricio Figueroa Olivares. All rights reserved.
//

import Foundation

class Tags: NSObject {
    
    // Propiedades
    var _name: String!
    var _displayName: String!
    
    var name: String {
        
        return _name
    }
    
    var displayName: String {
        return _displayName
    }
    
    // Constructor de la clase
    init(name: String, displayName: String) {
        self._name = name
        self._displayName = displayName
    }
    
    
}
