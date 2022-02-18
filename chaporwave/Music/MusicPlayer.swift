//
//  MusicPlayer.swift
//  chaporwave
//
//  Created by Alessandra Souza da Silva on 17/02/22.
//


import Foundation
import AVFoundation

class MusicPlayer {
    
    static let shared = MusicPlayer()
    static var audioPlayer: AVAudioPlayer?
    static var backgroundPlayer: AVAudioPlayer?
    static var gameoverPlayer: AVAudioPlayer?
    
    func startMusic(music: String) {
        if Defaults.getSound() {
            if let bundle = Bundle.main.path(forResource: music, ofType: "mp3") {
                let backgroundMusic = NSURL(fileURLWithPath: bundle)
                do {
                    MusicPlayer.audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                    guard let audioPlayer = MusicPlayer.audioPlayer else { return }
                    audioPlayer.numberOfLoops = 0
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
                } catch {
                    print(error)
                }
                
            }
        }
    }
    
    func startBackgroundMusic() {
        print(Defaults.getMusic())
        if Defaults.getMusic() {
            if let bundle = Bundle.main.path(forResource: "chaporwave", ofType: "mp3") {
                let backgroundMusic = NSURL(fileURLWithPath: bundle)
                do {
                    print("**********")
                    MusicPlayer.backgroundPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                    guard let backgroundPlayer = MusicPlayer.backgroundPlayer else { return }
                    backgroundPlayer.numberOfLoops = -1
                    backgroundPlayer.prepareToPlay()
                    backgroundPlayer.play()
                } catch {
                    print(error)
                }
                
            }
        }
    }
    func startGameOverMusic() {
        if Defaults.getSound() {
            if let bundle = Bundle.main.path(forResource: "gameover", ofType: "mp3") {
                let backgroundMusic = NSURL(fileURLWithPath: bundle)
                do {
                    MusicPlayer.gameoverPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                    guard let gameoverPlayer = MusicPlayer.gameoverPlayer else { return }
                    gameoverPlayer.numberOfLoops = 0
                    gameoverPlayer.prepareToPlay()
                    gameoverPlayer.play()
                } catch {
                    print(error)
                }
                
            }
        }
    }
    
    func stopBackgroundMusic() {
        guard let backgroundPlayer = MusicPlayer.backgroundPlayer else { return }
        backgroundPlayer.stop()
    }
}
