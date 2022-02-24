//
//  PauseViewController.swift
//  chaporwave
//
//  Created by Alessandra Souza da Silva on 15/02/22.
//

import UIKit

class PauseViewController: UIViewController {

    private var hapticManager = HapticManager()
    private var backgroundAudio = MusicPlayer()
    
    var gameVC: GameViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tutorial(_ sender: Any) {
    }
    
    @IBAction func settings(_ sender: Any) {
        hapticManager?.playClick()
        backgroundAudio.startMusic(music: "click")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "Settings") as! SettingsViewController
        
        navigationController?.pushViewController(vc, animated: false)
        
    }
    
    @IBAction func newGame(_ sender: Any) {
        hapticManager?.playClick()
        backgroundAudio.startMusic(music: "click")
        gameVC.reset()
        navigationController?.popViewController(animated: false)
        
    }
    
    @IBAction func resume(_ sender: Any) {
        gameVC.gameTimer.pauseTimer()
        hapticManager?.playClick()
        backgroundAudio.startMusic(music: "click")
        navigationController?.popViewController(animated: false)
        
        
    }
    @IBAction func menu(_ sender: Any) {
        hapticManager?.playClick()
        backgroundAudio.startMusic(music: "click")
        gameVC.reset()
        navigationController?.popToRootViewController(animated: false)
        
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
