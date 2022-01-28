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

    override func didMove(to view: SKView) {
        
        var name: String
        for _ in 0..<10 {
            let color = Color.allCases.randomElement()
            let shape = Shape.allCases.randomElement()
            name = shape!.rawValue + color!.rawValue
            print(name)
            nodePrimary.name = name
            
            backgroundColor = SKColor.white
       
            nodePrimary.position = CGPoint(x: 100, y: 100)
            addChild(nodePrimary)
            
        }
    
    }
    
    func touchDown(atPoint pos : CGPoint) {
       
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        

    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
