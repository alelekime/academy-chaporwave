
import SpriteKit
import GameplayKit
import FirebaseAnalytics
import AVFoundation



class GameScene: SKScene {

    private var nodeScore: SKLabelNode!
    
    
    private var nodePrimary: Node!
    private var nodeLeft: Node!
    private var nodeRight: Node!
    
    private var teaCup: SKSpriteNode!
    
    private var hapticManager: HapticManager!
  
    private var currentAttribute: Attribute!
    
    weak var gameVC: GameViewController!
    
    private var backgroundAudio = MusicPlayer()

    override func didMove(to view: SKView) {
        addScore()
        //addTeaCup()
        reset()
        hapticManager = HapticManager()
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    func updateAttributeNode() {
        currentAttribute = Attribute.allCases.randomElement()
        
        gameVC?.currentText.text = currentAttribute.rawValue.lowercased()

    }
    
    
    func addScore() {
        nodeScore = SKLabelNode(fontNamed: "Pangolin-Regular")
        nodeScore.fontSize = 90
        nodeScore.fontColor = UIColor(named: "darkBeige")
        nodeScore.position = CGPoint(x: 0, y: 500)
        nodeScore.text = "0000"
        
        
        addChild(nodeScore)
    }
    
    func addTeaCup() {
        teaCup = SKSpriteNode(imageNamed: "Teacup")
        teaCup.position = CGPoint(x: 0, y: -450)
        
        addChild(teaCup)
    }
    
    
    func createNodes() {
        nodePrimary = Node()
        nodePrimary.node.setScale(0.7)
        nodeLeft = nodePrimary.getMatch(condition: currentAttribute)
        nodeLeft.node.setScale(0.6)
        nodeRight = nodePrimary.getUnmatch(condition: currentAttribute)
        nodeRight.node.setScale(0.6)
        
        if Int.random(in: 0..<100) < 50{
            swap(&nodeLeft, &nodeRight)
        }
        
        nodePrimary.node.position = CGPoint(x: 0, y: 140)
        nodeLeft.node.position = CGPoint(x: -130, y: -120)
        nodeRight.node.position = CGPoint(x: 138, y: -120)

        addChild(nodePrimary.node)
        addChild(nodeLeft.node)
        addChild(nodeRight.node)
    }
    
    
    
    
    func playClick() {
        hapticManager?.playClick()
        backgroundAudio.startMusic(music: "click")
    }
    
    func cleanScreen() {
        nodePrimary.node.removeFromParent()
        nodeLeft.node.removeFromParent()
        nodeRight.node.removeFromParent()
        nodeScore.removeFromParent()
    }
    
    
    
    func updateScore(check: Bool) {
        if check {
            GameManager.score += 10
        } 
        nodeScore.text = String(format: "%04d", GameManager.score)
        print("score: \(GameManager.score)")
        
    }
    func gameOverCheck(check: Bool){
        if !check {
            Analytics.logEvent("level_end", parameters: nil)
            backgroundAudio.startGameOverMusic()
            gameVC!.showAd()
            gameVC?.gameOver()
        }
    }
    
    func reset() {
        if nodePrimary != nil{
            nodePrimary.node.removeFromParent()
            nodeLeft.node.removeFromParent()
            nodeRight.node.removeFromParent()
        }
        
        updateAttributeNode()
        createNodes()
    }
    
    func resetScore() {
        GameManager.score = 0
        nodeScore.text = String(format: "%04d", GameManager.score)
        
    }
    
    func updateGame(check: Bool) {
        updateScore(check: check)
        reset()
    }
    
    func matchIsPrimaryNode(_ node: Node) -> Bool {
        nodePrimary.isMatch(node, currentAttribute)
    }
    
    func testMacth(on node: Node, location: CGPoint) {
        if atPoint(location) == node.node {
            hapticManager?.playTeaBag()
            backgroundAudio.startMusic(music: "teabags")
            let check = matchIsPrimaryNode(node)
            gameOverCheck(check: check)
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
