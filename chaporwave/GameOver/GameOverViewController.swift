//
//  GameOverViewController.swift
//  chaporwave
//
//  Created by Alessandra Souza da Silva on 09/02/22.
//

import UIKit
import GameKit
import SpriteKit

class GameOverViewController: UIViewController, GKGameCenterControllerDelegate {
    

    
    @IBOutlet weak var scoreLabel: UILabel!
    var gameVC: GameViewController!
    private var hapticManager = HapticManager()
    private var backgroundAudio = MusicPlayer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = String(format: "%04d", GameManager.score)
        
    }
    
    @IBAction func newGame(_ sender: Any) {
        hapticManager?.playClick()
        backgroundAudio.startMusic(music: "click")
        gameVC.reset()
        navigationController?.popViewController(animated: false)
        
    }
    
    @IBAction func leaderboard(_ sender: Any) {
        hapticManager?.playClick()
        backgroundAudio.startMusic(music: "click")
    
        
        let viewController = GKGameCenterViewController(
                        leaderboardID: "chaporwave.leaderboard",
                        playerScope: .global,
                        timeScope: .allTime)
        viewController.gameCenterDelegate = self
        present(viewController, animated: true, completion: nil)
    }
        
    @IBAction func menu(_ sender: Any) {
        hapticManager?.playClick()
        backgroundAudio.startMusic(music: "click")
        gameVC.reset()
        navigationController?.popToRootViewController(animated: false)
    
        
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
