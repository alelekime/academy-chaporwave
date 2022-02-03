import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var nodeClose: SKSpriteNode!
    private var nodeSettings: SKSpriteNode!
    
    private var nodeScore: SKLabelNode!
    private var score: Int! = 0
    
    private var nodePrimary: Node!
    private var nodeLeft: Node!
    private var nodeRight: Node!
    
    private var textGame: SKSpriteNode!
    private var currentAttribute: Attribute!
    
    override func didMove(to view: SKView) {
        addScore()
        
        backgroundColor = UIColor(named: "backgroundColor")!
        next()
    }
    
    func touchDown(atPoint pos : CGPoint) {
        next()
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    func updateAttributeNode() {
        currentAttribute = Attribute.allCases.randomElement()
        
        textGame = SKSpriteNode(imageNamed: currentAttribute.rawValue)
        textGame.position = CGPoint(x: 0, y: 340)
        addChild(textGame)
    }
    
    
    func addScore() {
        nodeScore = SKLabelNode(fontNamed: "Chalkduster")
        nodeScore.fontSize = 90
        nodeScore.fontColor = SKColor.white
        nodeScore.position = CGPoint(x: 0, y: 490)
        nodeScore.text = "0000"
        
        addChild(nodeScore)
    }
    
    
    func createNodes() {
        nodeClose = SKSpriteNode(imageNamed: "close")
        nodeSettings = SKSpriteNode(imageNamed: "gear")
        nodePrimary = Node()
        nodePrimary.node.setScale(0.7)
        nodeLeft = nodePrimary.getMatch(condition: currentAttribute)
        nodeLeft.node.setScale(0.6)
        nodeRight = nodePrimary.getUnmatch(condition: currentAttribute)
        nodeRight.node.setScale(0.6)
        
        if Int.random(in: 0..<100) < 50{
            swap(&nodeLeft, &nodeRight)
        }
        
        nodeClose.position = CGPoint(x: -250, y: 600)
        nodeSettings.position = CGPoint(x: 250, y: 600)
        
        nodePrimary.node.position = CGPoint(x: 26, y: 220)
        nodeLeft.node.position = CGPoint(x: -130, y: -120)
        nodeRight.node.position = CGPoint(x: 138, y: -120)
        
        addChild(nodeClose)
        addChild(nodeSettings)
        addChild(nodePrimary.node)
        addChild(nodeLeft.node)
        addChild(nodeRight.node)
    }
    
    
    func updateScore(check: Bool) {
        if check {
            score += 10
        } else {
            score -= 10
        }
        nodeScore.text = String(format: "%04d", score)
    }
    
    
    func next() {
        
        if nodePrimary != nil{
            nodePrimary.node.removeFromParent()
            nodeLeft.node.removeFromParent()
            nodeRight.node.removeFromParent()
            textGame.removeFromParent()
        }
        updateAttributeNode()
        createNodes()
    }
    
    
    func checkAnswer(check: Bool) {
        if check {
            backgroundColor = .green
            print("true")
        } else {
            backgroundColor = .red
            print("false")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.backgroundColor = UIColor(named: "backgroundColor")!
        }
    }
    
    func updateGame(check: Bool) {
        checkAnswer(check: check)
        updateScore(check: check)
        next()
    }
    
    func matchIsPrimaryNode(_ node: Node) -> Bool {
        nodePrimary.isMatch(node, currentAttribute)
    }
    
    func testMacth(on node: Node, location: CGPoint) {
        if atPoint(location) == node.node {
            let check = matchIsPrimaryNode(node)
            updateGame(check: check)
        }
    }
    
    func changeScene(scene: SKScene) {
        scene.scaleMode = .aspectFill
        view!.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            testMacth(on: nodeLeft, location: location)
            testMacth(on: nodeRight, location: location)
        
            if atPoint(location) == nodeClose {
                if let scene = MenuScene(fileNamed: "MenuScene") {
                    changeScene(scene: scene)
                }
            }
            if atPoint(location) == nodeSettings {
                if let scene = SettingsScene(fileNamed: "SettingsScene") {
                    changeScene(scene: scene)
                }
            }
        }
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
