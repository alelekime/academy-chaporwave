//
//  Haptics.swift
//  chaporwave
//
//  Created by Alessandra Souza da Silva on 16/02/22.
//

import CoreHaptics

class HapticManager {
    
    let hapticEngine: CHHapticEngine
    

    init?() {
        let hapticCapability = CHHapticEngine.capabilitiesForHardware()
        guard hapticCapability.supportsHaptics else {
            return nil
        }
        do {
            hapticEngine = try CHHapticEngine()
        } catch let error {
            print("Haptic engine Creation Error: \(error)")
            return nil
        }
        do {
            try hapticEngine.start()
        } catch let error {
            print("Haptic failed to start Error: \(error)")
        }
        hapticEngine.isAutoShutdownEnabled = true
        
        
//        hapticEngine.resetHandler = { [weak self] in
//            self?.handleEngineReset()
//        }
    }
    
}


extension HapticManager {
    private func touchTeaBag() throws -> CHHapticPattern {
        let slice = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.35),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.25)
            ],
            relativeTime: 0,
            duration: 0.25)
        
    
        
        return try CHHapticPattern(events: [slice], parameters: [])
        
    }
    func playTeaBag() {
        if Defaults.getVibrations() {
            do {
                let pattern = try touchTeaBag()
                try hapticEngine.start()
                let player = try hapticEngine.makePlayer(with: pattern)
                try player.start(atTime: CHHapticTimeImmediate)
                hapticEngine.notifyWhenPlayersFinished { _ in
                  return .stopEngine
                }
              } catch {
                print("Failed to play slice: \(error)")
              }
        }
    }
    
    private func touchClick() throws -> CHHapticPattern {
        let slice = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0)
            ],
            relativeTime: 0,
            duration: 0.25)
        
        return try CHHapticPattern(events: [slice], parameters: [])
        
    }
    
    func playClick() {
        if Defaults.getVibrations() {
            do {
                let pattern = try touchClick()
                try hapticEngine.start()
                let player = try hapticEngine.makePlayer(with: pattern)
                try player.start(atTime: CHHapticTimeImmediate)
                hapticEngine.notifyWhenPlayersFinished { _ in
                  return .stopEngine
                }
              } catch {
                print("Failed to play slice: \(error)")
              }
        }
        
    }
    
    func handleEngineReset() {
        do {
            try hapticEngine.start()
           
        } catch {
            print("Failed to restart the engine: \(error)")
        }
    }
}


