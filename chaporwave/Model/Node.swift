//
//  Sprite.swift
//  chaporwave
//
//  Created by Alessandra Souza da Silva on 27/01/22.
//

import Foundation


enum Shape: String, CaseIterable {
    case Space
    case Bunny
    
    static func == (lhs:Self, rhs:Self) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

enum Color: String, CaseIterable{
    case Pink
    case Yellow
    case Green
    case Peach
    case Blue

    static func == (lhs:Self, rhs:Self) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
    
}


class Node {
    let image: String
    let shape: Shape
    let color: Color
    
    init(image: String, shape: Shape, color: Color) {
        self.image = image
        self.shape = shape
        self.color = color
    }
    
    static func getMatchColor(colorPrimary: Color, colorSecondary: Color) -> Bool {
        if colorPrimary.rawValue == colorSecondary.rawValue {
            return true
        }
        return false
        
        
    }
    static func getMatchShape(shapePrimary: Shape, shapeSecondary: Shape) -> Bool {
        if shapePrimary.rawValue == shapeSecondary.rawValue {
            return true
        }
        return false
    }
    
}
