//
//  GameViewController2.swift
//  chaporwave
//
//  Created by Alessandra Souza da Silva on 22/02/22.
//

import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds
import GameKit


class GameViewController: UIViewController, GADFullScreenContentDelegate {

    var scene: GameScene!
    var bannerView: GADBannerView!
    var interstitial: GADInterstitialAd?
    
    private var hapticManager = HapticManager()
    private var backgroundAudio = MusicPlayer()
    
    
    var gameTimer: GameTimer!
    
    @IBOutlet weak var teaImageTimer: UIImageView!
    @IBOutlet weak var currentText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            scene = SKScene(fileNamed: "GameScene") as? GameScene
            scene.gameVC = self
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
        }
        requestBanner()
        requestInterstitial()
        gameTimer = GameTimer(imageTea: teaImageTimer, gameScene: scene)
        gameTimer.startTimer()
    }
    
    func requestBanner() {
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    func requestInterstitial() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",
                               request: request,
                               completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
        })
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view!.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
        print("********")
    }
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did present full screen content.")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        requestInterstitial()
        print("********")
    }

    
    func gameOver() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "GameOver") as! GameOverViewController
        
        vc.gameVC = self
        
        navigationController?.pushViewController(vc, animated: false)
    
        GKLeaderboard.submitScore(
            GameManager.score,
            context: 0,
            player: GKLocalPlayer.local,
            leaderboardIDs: ["chaporwave.leaderboard"]
        ) { error in
            print(error ?? "aaaa")
        }
    }
    func stopTimer() {
        gameTimer.stopTimer()
    }
    func pauseTimer() {
        gameTimer.pauseTimer()
    }
    
    func reset() {
        scene.reset()
        scene.resetScore()
        gameTimer.reset()
        
    }
    
    func showAd() {
        if interstitial != nil {
            interstitial!.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    @IBAction func pause(_ sender: Any) {
        hapticManager?.playClick()
        backgroundAudio.startMusic(music: "click")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "Pause")
        
        navigationController?.pushViewController(vc, animated: false)
        gameTimer.pauseTimer()
    }
    
    
    @IBAction func settingsPressed(_ sender: Any) {
        hapticManager?.playClick()
        backgroundAudio.startMusic(music: "click")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "Settings")
        
        navigationController?.pushViewController(vc, animated: false)
        
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
