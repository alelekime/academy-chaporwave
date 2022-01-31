//
//  MenuScene.swift
//  chaporwave
//
//  Created by Alessandra Souza da Silva on 31/01/22.
//

import SpriteKit

class MenuScene: SKScene {
    
    private var logo: SKSpriteNode!
    private var startButton: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        backgroundColor = UIColor(named: "backgroundColor")!
        addButtons()
    }
    
    func addButtons() {
        logo = SKSpriteNode(imageNamed: "logo")
        logo.name = "logo"
        logo.position = CGPoint(x: 0, y: 300)
        addChild(logo)
        
        let labelStartButton = SKLabelNode(fontNamed: "Arial")
        
        labelStartButton.text = "Start"
        labelStartButton.fontColor = .black
        labelStartButton.verticalAlignmentMode = .center
        labelStartButton.fontSize = 29.0
        labelStartButton.zPosition = 1
        
        
        
        startButton = SKSpriteNode(color: .white, size: CGSize(width: 150, height: 100))
        
        startButton.addChild(labelStartButton)
        startButton.position = CGPoint(x: 0, y: 0)
        addChild(startButton)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self);
            
            if atPoint(location) == startButton {
                
                if let scene = GameScene(fileNamed: "GameScene") {
                    scene.scaleMode = .aspectFill
                    view!.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
                }
                
            }
        }
    }
    
    
}
