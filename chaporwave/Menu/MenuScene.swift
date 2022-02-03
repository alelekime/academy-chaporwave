//
//  MenuScene.swift
//  chaporwave
//
//  Created by Alessandra Souza da Silva on 31/01/22.
//

import SpriteKit

class MenuScene: SKScene {
    
    private var logo: SKSpriteNode!
    private var playButton: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        addButtons()
    }
    
    func addButtons() {
        
        playButton = SKSpriteNode(imageNamed: "playButton")
        playButton.position = CGPoint(x: 0, y: -480)
        addChild(playButton)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self);
            
            if atPoint(location) == playButton {
                
                if let scene = GameScene(fileNamed: "GameScene") {
                    scene.scaleMode = .aspectFill
                    view!.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
                }
                
            }
        }
    }
    
    
}
