//
//  CustomizableButton.swift
//  ClientImgur
//
//  Created by Mauricio Figueroa Olivares on 05-06-17.
//  Copyright © 2017 Mauricio Figueroa Olivares. All rights reserved.
//

import UIKit

@IBDesignable class CustomizableButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet {
            
            layer.cornerRadius = cornerRadius
            
        }
        
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        
        didSet {
            
            layer.borderWidth = borderWidth
        }
        
    }
    
    @IBInspectable var borderColor: CGColor? = UIColor.white.cgColor {
        
        didSet {
            
            layer.borderColor = borderColor
        }
        
    }
    
}
