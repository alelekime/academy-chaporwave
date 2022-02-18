//
//  Defaults.swift
//  chaporwave
//
//  Created by Alessandra Souza da Silva on 17/02/22.
//


import UIKit

struct Defaults {
    
    struct UserDetails {
        var music: Bool
        var sound: Bool
        var vibrations: Bool
    }
    
    static func saveMusic(music: Bool){
        UserDefaults.standard.set(music,
                        forKey: "music")
    }
    
    static func saveSound(sound: Bool){
        UserDefaults.standard.set(sound,
                        forKey: "sound")
    }
    
    static func saveVibrations(vibrations: Bool){
        UserDefaults.standard.set(vibrations,
                        forKey: "vibrations")
    }
    
    static func getMusic() -> Bool {
        (UserDefaults.standard.value(forKey: "music") != nil) ? UserDefaults.standard.bool(forKey: "music") : true
    }
    
    static func getSound() -> Bool {
        (UserDefaults.standard.value(forKey: "sound") != nil) ? UserDefaults.standard.bool(forKey: "sound") : true
       
    }
    
    static func getVibrations() -> Bool {
        (UserDefaults.standard.value(forKey: "vibrations") != nil) ? UserDefaults.standard.bool(forKey: "vibrations") : true
    }
    
    static func clearUserData(value: String){
        UserDefaults.standard.removeObject(forKey: value)
    }
}
