//
//  GameScene.swift
//  chaporwave
//
//  Created by Alessandra Souza da Silva on 27/01/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var nodePrimary: SKSpriteNode!
    private var nodeLeft: SKSpriteNode!
    private var nodeRight: SKSpriteNode!
    var colors = Color.allCases
    var shapes = Shape.allCases
    
    
    override func didMove(to view: SKView) {
        
        backgroundColor = UIColor(named: "backgroundColor")!
        next()
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        next()
    }
    
    func next() {
        
        if nodePrimary != nil{
            nodePrimary.removeFromParent()
            nodeLeft.removeFromParent()
            nodeRight.removeFromParent()
        }
        
        var colors = Color.allCases
        var shapes = Shape.allCases
        var color = colors.popRandomElement()
        var shape = shapes.popRandomElement()
        var name = shape!.rawValue + color!.rawValue
        nodePrimary = SKSpriteNode(imageNamed: name)
        
        shape = shapes.popRandomElement()
        name = shape!.rawValue + color!.rawValue
        nodeLeft = SKSpriteNode(imageNamed: name)
        color = colors.popRandomElement()
        
        name = shape!.rawValue + color!.rawValue
        nodeRight = SKSpriteNode(imageNamed: name)
        
        if Int.random(in: 0..<100) < 50{
            swap(&nodeLeft, &nodeRight)
        }
        
        nodePrimary.position = CGPoint(x: 40, y: 250)
        nodeLeft.position = CGPoint(x: -150, y: -100)
        nodeRight.position = CGPoint(x: 150, y: -100)
        
        addChild(nodePrimary)
        addChild(nodeLeft)
        addChild(nodeRight)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
    
}



extension Array {
    mutating func popRandomElement() -> Element? {
        guard !isEmpty else {
            return nil
        }
        let index = Int.random(in: 0..<count)
        let element = self[index]
        self.remove(at: index)
        return element
    }
}
