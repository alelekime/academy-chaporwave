//
//  SettingsScene.swift
//  chaporwave
//
//  Created by Alessandra Souza da Silva on 02/02/22.
//

import SpriteKit

class SettingsScene: SKScene {
    
    private var settingsTitle: SKSpriteNode!
    private var nodeClose: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        backgroundColor = UIColor(named: "backgroundColor")!
        addButtons()
    }
    
    func addButtons() {
        nodeClose = SKSpriteNode(imageNamed: "close")
        nodeClose.name = "nodeClose"
        nodeClose.position = CGPoint(x: -250, y: 600)
        addChild(nodeClose)
        
        let labelSettingTitle = SKLabelNode(fontNamed: "Arial")
        
        labelSettingTitle.text = "Settings"
        labelSettingTitle.fontColor = .white
        labelSettingTitle.verticalAlignmentMode = .center
        labelSettingTitle.fontSize = 29.0
        labelSettingTitle.zPosition = 1
        
        
        
        settingsTitle = SKSpriteNode(color: .clear, size: CGSize(width: 150, height: 100))
        
        settingsTitle.addChild(labelSettingTitle)
        settingsTitle.position = CGPoint(x: 0, y: 470)
        addChild(settingsTitle)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self);
            
            if atPoint(location) == nodeClose {
                
                if let scene = GameScene(fileNamed: "GameScene") {
                    scene.scaleMode = .aspectFill
                    view!.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
                }
                
            }
        }
    }
    
    
}
