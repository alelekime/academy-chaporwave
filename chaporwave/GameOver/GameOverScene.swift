//
//  GameOverScene.swift
//  chaporwave
//
//  Created by Alessandra Souza da Silva on 08/02/22.
//

import SpriteKit
import GameplayKit
import FirebaseAnalytics

class GameOverScene: SKScene {
    
    private var nodeGameOver: SKLabelNode!
    
    private var nodeNewGame: SKSpriteNode!
    private var nodeMenu: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        createNodes()
        
    }
    
    func createNodes() {
        let nodeGameOver = SKLabelNode(fontNamed: "Chalkduster")
        nodeGameOver.fontSize = 90
        nodeGameOver.fontColor = SKColor.white
        nodeGameOver.position = CGPoint(x: 0, y: 490)
        nodeGameOver.text = "Game \nOver"
        
        
        let nodeMenuText = SKLabelNode(fontNamed: "Chalkduster")
        nodeMenuText.fontSize = 90
        nodeMenuText.fontColor = SKColor.white
        nodeMenuText.position = CGPoint(x: 0, y: 290)
        nodeMenuText.text = "Menu"
        nodeMenu = SKSpriteNode(color: .clear, size: CGSize(width: 50, height: 50))
        nodeMenu.addChild(nodeMenuText)
        
        let nodeNewGameText = SKLabelNode(fontNamed: "Chalkduster")
        nodeNewGameText.fontSize = 90
        nodeNewGameText.fontColor = SKColor.white
        nodeNewGameText.position = CGPoint(x: 0, y: 90)
        nodeNewGameText.text = "New Game"
        nodeNewGame = SKSpriteNode(color: .clear, size: CGSize(width: 50, height: 50))
        nodeNewGame.addChild(nodeNewGameText)
        
        addChild(nodeGameOver)
        addChild(nodeMenu)
        addChild(nodeNewGame)
    }
    
    
    func changeScene(scene: SKScene) {
        scene.scaleMode = .aspectFill
        view!.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
//            if atPoint(location) == nodeMenu {
//                if let scene = MenuScene(fileNamed: "MenuScene") {
//                    scene.scaleMode = .aspectFill
//                    view!.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
//                }
//            }
            if atPoint(location) == nodeNewGame {
                Analytics.logEvent("level_reset", parameters: nil)
                if let scene = GameScene(fileNamed: "GameScene") {
                    scene.scaleMode = .aspectFill
                    view!.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
                }
            }
        }
    }
}
