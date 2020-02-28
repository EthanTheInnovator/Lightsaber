//
//  SaberManager.swift
//  Lightsaber
//
//  Created by Ethan Humphrey on 2/26/20.
//  Copyright © 2020 Ethan Humphrey. All rights reserved.
//

import Foundation
import CoreMotion
import AVFoundation

class SaberManager: ObservableObject {
    
    var motionManager = CMMotionManager()
    var lastAcceleration: CMAcceleration?
    
    var swingPlayer: AVAudioPlayer!
    var hitPlayer: AVAudioPlayer!
    var onPlayer: AVAudioPlayer!
    var offPlayer: AVAudioPlayer!
    var colorChangePlayer: AVAudioPlayer!
    var humPlayer: AVAudioPlayer!
    
    let maxRange = 0.05
    
    var isOn = false
    
    init() {
        do {
            try self.swingPlayer = AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "saberSwing", withExtension: "mp3")!)
            try self.hitPlayer = AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "saberCrash", withExtension: "mp3")!)
            try self.onPlayer = AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "saberOn2", withExtension: "mp4")!)
            try self.offPlayer = AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "saberOff2", withExtension: "mp4")!)
            try self.colorChangePlayer = AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "saberColorChange", withExtension: "mp4")!)
            try self.humPlayer = AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "saberHum", withExtension: "mp4")!)
            self.humPlayer.numberOfLoops = Int.max
            print(Int.max)
        }
        catch {
            print(error)
        }
        startMotionUpdates()
    }
    
    func turnOn() {
        isOn = true
        self.onPlayer.play()
        
        self.humPlayer.volume = 0
        self.humPlayer.play()
        self.humPlayer.setVolume(0.8, fadeDuration: 0.25)
        
    }
    
    func turnOff() {
        isOn = false
        self.offPlayer.play()
        self.humPlayer.setVolume(0, fadeDuration: 1)
    }
    
    let accelerometerQueue = OperationQueue()
    
    func startMotionUpdates() {
        motionManager.startDeviceMotionUpdates(to: accelerometerQueue) { (motionData, error) in
            self.recieveMotionUpdates(motionData)
        }
    }
    
    func recieveMotionUpdates(_ motionData: CMDeviceMotion?) {
        if isOn {
            if let lastAcc = self.lastAcceleration, let currentAcc = motionData?.userAcceleration {
                if currentAcc.magnitude > 0.7 {
                    if !self.swingPlayer.isPlaying || self.swingPlayer.currentTime > 0.6 {
                        self.swingPlayer.currentTime = 0
                        self.swingPlayer.play()
//                        self.hitPlayer.prepareToPlay()
                    }
                }
                if (currentAcc.magnitude - lastAcc.magnitude) > 2 {
                    if !self.hitPlayer.isPlaying {
                        self.hitPlayer.play()
                    }
                }
            }
        }
        self.lastAcceleration = motionData?.userAcceleration
    }
    
    func changeColor() {
        self.colorChangePlayer.play()
    }
    
}

extension CMAcceleration {
    var magnitude: Double {
        return sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
    }
}
