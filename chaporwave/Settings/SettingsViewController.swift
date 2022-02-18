//
//  SettingsViewController.swift
//  chaporwave
//
//  Created by Alessandra Souza da Silva on 14/02/22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var switchMusicState: UISwitch!
    @IBOutlet var switchSoundState: UISwitch!
    @IBOutlet var switchVibrationsState: UISwitch!
    
    private var hapticManager = HapticManager()
    private var backgroundAudio = MusicPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchMusicState.setOn(Defaults.getMusic(), animated: true)
        switchSoundState.setOn(Defaults.getSound(), animated: true)
        switchVibrationsState.setOn(Defaults.getVibrations(), animated: true)
    }
    
    
    @IBAction func switchMusic(_ sender: Any) {
        if switchMusicState.isOn {
            Defaults.saveMusic(music: true)
            backgroundAudio.startBackgroundMusic()
        } else {
            print("off")
            Defaults.saveMusic(music: false)
            backgroundAudio.stopBackgroundMusic()
            
        }
    }
    
    @IBAction func switchSound(_ sender: Any) {
        if switchSoundState.isOn {
            Defaults.saveSound(sound: true)
            
        } else {
            Defaults.saveSound(sound: false)
        }
    }
    
    @IBAction func switchVibrations(_ sender: Any) {
        if switchVibrationsState.isOn {
            Defaults.saveVibrations(vibrations: true)
            
        } else {
            Defaults.saveVibrations(vibrations: false)
        }
    }
    
    @IBAction func close(_ sender: Any) {
        hapticManager?.playClick()
        backgroundAudio.startMusic(music: "click")
        navigationController?.popViewController(animated: false)
        
    }
    @IBAction func play(_ sender: Any) {
        hapticManager?.playClick()
        backgroundAudio.startMusic(music: "click")
        navigationController?.popViewController(animated: false)
        
    }
    @IBAction func newGame(_ sender: Any) {
        hapticManager?.playClick()
        backgroundAudio.startMusic(music: "click")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "Game")
        
       
        navigationController?.pushViewController(vc, animated: false)
        
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
