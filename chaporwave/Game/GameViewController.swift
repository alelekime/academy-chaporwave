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
    

    @IBOutlet weak var scoreText: UILabel!
    @IBOutlet weak var teaImageTimer: UIImageView!
    @IBOutlet weak var currentText: UILabel!

    @IBOutlet weak var heartOne: UIImageView!
    @IBOutlet weak var heartTwo: UIImageView!
    @IBOutlet weak var heartThree: UIImageView!
    var numberHearts = 3
    
    
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

        scoreText.text = String(format: "%04d", GameManager.score)
        updateHeart(number: 0)
    }
    func updateTime(deltaTime: TimeInterval) {
        gameTimer.update(deltaTime: deltaTime)
    }
    
    
    
    func requestBanner() {
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    func startHearts() {
        heartOne.image = UIImage(systemName: "heart.fill")?.withTintColor(UIColor(named: "linePurple")!)
        heartTwo.image = UIImage(systemName: "heart.fill")?.withTintColor(UIColor(named: "linePurple")!)
        heartThree.image = UIImage(systemName: "heart.fill")?.withTintColor(UIColor(named: "linePurple")!)
        
    }
    
    func updateHeart(number: Int) {
        print(numberHearts)
        switch number {
        case 3:
            heartOne.image = UIImage(systemName: "heart")?.withTintColor(UIColor(named: "linePurple")!)
        case 2:
            heartTwo.image = UIImage(systemName: "heart")?.withTintColor(UIColor(named: "linePurple")!)
        case 1:
            heartThree.image = UIImage(systemName: "heart")?.withTintColor(UIColor(named: "linePurple")!)
        
        default:
            startHearts()
        }
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
    
    func resetTimer() {
        gameTimer!.reset()
    }
    
    
    func pauseTimer() {
        gameTimer!.pauseTimer()
    }
    
    func reset() {
        scene.reset()
        scene.resetScore()
        gameTimer!.reset()
        numberHearts = 3
        updateHeart(number: 0)
        
        
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
        gameTimer.pauseTimer()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "Pause") as! PauseViewController
        vc.gameVC = self
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
