//
//  CustomizableTextfield.swift
//  ClientImgur
//
//  Created by Mauricio Figueroa Olivares on 05-06-17.
//  Copyright © 2017 Mauricio Figueroa Olivares. All rights reserved.
//

import UIKit

@IBDesignable class CustomizableTextField: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet {
            
            layer.cornerRadius = cornerRadius
            
        }
        
    }
    
}
