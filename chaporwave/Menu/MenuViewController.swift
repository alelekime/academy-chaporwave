//
//  MenuViewController.swift
//  chaporwave
//
//  Created by Alessandra Souza da Silva on 09/02/22.
//

import UIKit
import SpriteKit
import GameKit

class MenuViewController: UIViewController, GKGameCenterControllerDelegate {
    
    var gcEnabled: Bool! // Check if the user has Game Center enabled
    var gcDefaultLeaderBoard: String! // Check the default leaderboardID

    private var hapticManager = HapticManager()
    
    private var backgroundAudio = MusicPlayer()
    
    var gameVC: GameViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        authenticateLocalPlayer()
        
        backgroundAudio.startBackgroundMusic()
    }
    
    @IBAction func settings(_ sender: Any) {
        hapticManager?.playClick()
        backgroundAudio.startMusic(music: "click")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "Settings")
        
        navigationController?.pushViewController(vc, animated: false)
        
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
    
    
    @IBAction func play(_ sender: Any) {
        hapticManager?.playClick()
        backgroundAudio.startMusic(music: "click")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "Game")
        
        navigationController?.pushViewController(vc, animated: false)
        
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    func authenticateLocalPlayer() {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.local
             
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if((ViewController) != nil) {
                self.present(ViewController!, animated: true, completion: nil)
            } else if (localPlayer.isAuthenticated) {
                self.gcEnabled = true
                localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifer, error) in
                    if error != nil { print(error!)
                    } else { self.gcDefaultLeaderBoard = leaderboardIdentifer! }
                })
            } else {
                self.gcEnabled = false
                print("Local player could not be authenticated!")
                print(error!)
            }
        }
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
