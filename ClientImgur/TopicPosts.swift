//
//  TopicPosts.swift
//  ClientImgur
//
//  Created by Mauricio Figueroa Olivares on 03-06-17.
//  Copyright © 2017 Mauricio Figueroa Olivares. All rights reserved.
//

import Foundation

class TopicPosts: NSObject {
    
    // Propiedades
    var _id: String!
    var _title: String!
    var _description: String?
    var _datetime: NSNumber!
    var _views: Int!
    var _link: String!
    var _ups: Int!
    var _downs: Int!
    
    var id: String {
        
        return _id
    }
    
    var title: String {
        return _title
    }
    
    var descripcion : String? {
        return _description
    }
    
    var datetime: NSNumber {
        return _datetime
    }
    
    var views: Int {
        return _views
    }
    
    var link: String {
        return _link
    }
    
    var ups: Int {
        return _ups
    }
    
    var downs: Int {
        return _downs
    }
    
    
    // Constructor de la clase
    init(id: String, title: String, description: String?, datetime: NSNumber, views: Int, link: String, ups: Int, downs: Int) {
        self._id = id
        self._title = title
        self._description = description
        self._datetime = datetime
        self._views = views
        self._link = link
        self._ups = ups
        self._downs = downs
    }
    
    
}
