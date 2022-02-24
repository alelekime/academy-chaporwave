//
//  Timer.swift
//  chaporwave
//
//  Created by Alessandra Souza da Silva on 20/02/22.
//

import UIKit
import Foundation


class GameTimer {
    var timeInterval: TimeInterval! = 2
    var currentTime: TimeInterval! = 0
    var currentIndex: Int = 0
    let teaImagesArray = ["tea1.png", "tea2.png", "tea3.png","tea4.png", "tea5.png"]
    var imageTea: UIImageView!
    var gameScene: GameScene!
    var isPaused = false    
    
    init(imageTea: UIImageView, gameScene: GameScene) {
        self.imageTea = imageTea
        self.gameScene = gameScene
    }
    
    func update(deltaTime: TimeInterval) {
        if currentIndex >= teaImagesArray.count {
            return
        }
        if isPaused {
            return
        }
        currentTime += deltaTime
        if currentTime >= timeInterval {
            currentIndex += 1
            currentTime = 0
            if currentIndex >= teaImagesArray.count {
                gameScene.gameOver()
            } else {
                updateImage()
            }
        }
    }
    
    func updateImage() {
        self.imageTea.image = UIImage(named: teaImagesArray[currentIndex])
    }
    
    func reset() {
        currentIndex = 0
        currentTime = 0
        updateImage()
    }
    
    func pauseTimer() {
        print(isPaused)
        isPaused = !isPaused
        print(isPaused)
    }
    
}
