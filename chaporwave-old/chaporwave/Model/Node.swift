//
//  Sprite.swift
//  chaporwave
//
//  Created by Alessandra Souza da Silva on 27/01/22.
//

import Foundation
import SpriteKit


protocol Randomizible: CaseIterable {
    static func getRandom() -> Self
}
extension Randomizible {
    static func getRandom() -> Self {
        Self.allCases.randomElement()!
    }
}

enum Pattern: String, Randomizible{
    case Space
    case Bunny
    case Carrot
    case Star
    case Heart
    case Spring
    
    static func == (lhs:Self, rhs:Self) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

enum Color: String, Randomizible {
    case Pink
    case Yellow
    case Green
    case Peach
    case Blue
    
    static func == (lhs:Self, rhs:Self) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

enum Attribute: String, CaseIterable {
    case Pattern
    case Color
}


class Node {
    var image: String
    var pattern: Pattern
    var color: Color
    var node: SKSpriteNode!
    
    
    init(pattern: Pattern, color: Color) {
        let imageName = pattern.rawValue + color.rawValue
        let imageNode = SKSpriteNode(imageNamed: imageName)
        self.image = imageName
        self.pattern = pattern
        self.color = color
        self.node = imageNode
    }
    
    convenience init() {
        var colors = Color.allCases
        var patterns = Pattern.allCases
        let color = colors.popRandomElement() ?? .Blue
        let pattern = patterns.popRandomElement() ?? .Bunny
        
        self.init(pattern: pattern, color: color)
    }
    
    func getMatch(condition: Attribute) -> Node {
        switch condition {
        case .Pattern:
            return Node(pattern: pattern, color: Color.getRandom())
        case .Color:
            return Node(pattern: Pattern.getRandom(), color: color)
        }
    }
    
    func getUnmatch(condition: Attribute) -> Node {
        switch condition {
        case .Pattern:
            let selectedPattern = Pattern.allCases.filter { $0 != pattern }.randomElement() ?? .Bunny
            return Node(pattern: selectedPattern, color: Color.getRandom())
        case .Color:
            let selectedColor = Color.allCases.filter { $0 != color }.randomElement() ?? .Blue
            return Node(pattern: Pattern.getRandom(), color: selectedColor)
        }
    }

    func isMatch(_ node: Node, _ condition: Attribute) -> Bool {
        switch condition {
        case .Pattern:
            return node.pattern == pattern
        case .Color:
            return node.color == color
        }
    }
    
}
