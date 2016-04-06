//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Japan Parikh on 3/19/16.
//  Copyright © 2016 Japan Parikh. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var darthvaderButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    @IBAction func stopButtonPressed(sender: AnyObject) {
        print("Stop Button Pressed")
        audioPlayer.stop()
        snailButton.enabled = true
        rabbitButton.enabled = true
        chipmunkButton.enabled = true
        darthvaderButton.enabled = true
        echoButton.enabled = true
        reverbButton.enabled = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PlaySoundsViewController loaded")
//        if let filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
//            let filePathUrl = NSURL.fileURLWithPath(filePath)
//            
//        }else {
//            print("file not found")
//        }
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func playChipmunkAudio(sender: UIButton){
        print("Chipmunk Button Pressed")
        playAudioWithVariablePitch(1000)
        darthvaderButton.enabled = true
        chipmunkButton.enabled = false
        echoButton.enabled = true
        snailButton.enabled = true
        reverbButton.enabled = true
        rabbitButton.enabled = true
    }
    
    @IBAction func playVaderAudio(sender: UIButton){
        print("Darth Vader Button Pressed")
        playAudioWithVariablePitch(-1000)
        darthvaderButton.enabled = false
        chipmunkButton.enabled = true
        echoButton.enabled = true
        snailButton.enabled = true
        reverbButton.enabled = true
        rabbitButton.enabled = true
    }
    
    @IBAction func playReverbAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let reverbNode = AVAudioUnitReverb()
        reverbNode.loadFactoryPreset(.Cathedral)
        reverbNode.wetDryMix = 50
        audioEngine.attachNode(reverbNode)
        
        audioEngine.connect(audioPlayerNode, to: reverbNode, format: nil)
        audioEngine.connect(reverbNode, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        try! audioEngine.start()
        
        audioPlayerNode.play()
        
        darthvaderButton.enabled = true
        chipmunkButton.enabled = true
        echoButton.enabled = true
        snailButton.enabled = true
        reverbButton.enabled = false
        rabbitButton.enabled = true
        
    }
    
    
    @IBAction func playEchoAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let echoNode = AVAudioUnitDistortion()
        echoNode.loadFactoryPreset(.MultiEcho1)
        audioEngine.attachNode(echoNode)
        
        audioEngine.connect(audioPlayerNode, to: echoNode, format: nil)
        audioEngine.connect(echoNode, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        try! audioEngine.start()
        
        audioPlayerNode.play()
        
        darthvaderButton.enabled = true
        chipmunkButton.enabled = true
        echoButton.enabled = false
        snailButton.enabled = true
        reverbButton.enabled = true
        rabbitButton.enabled = true
    }
    
    
    func playAudioWithVariablePitch(pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format:  nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        try! audioEngine.start()
        
        audioPlayerNode.play()
        
    }
    
    func playAudio() {
        audioPlayer.stop()
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        audioPlayer.currentTime = 0.0
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
//        audioPlayer.stop()
        playAudio()
        audioPlayer.rate = 2.0
        print("Rabbit Button Pressed")
        darthvaderButton.enabled = true
        chipmunkButton.enabled = true
        echoButton.enabled = true
        snailButton.enabled = true
        reverbButton.enabled = true
        rabbitButton.enabled = false
//        audioPlayer.currentTime = 0.0
//        audioPlayer.play()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
//        audioPlayer.stop()
        playAudio()
        audioPlayer.rate = 0.5
        print("Snail Button Pressed")
        darthvaderButton.enabled = true
        chipmunkButton.enabled = true
        echoButton.enabled = true
        snailButton.enabled = false
        reverbButton.enabled = true
        rabbitButton.enabled = true
//        audioPlayer.currentTime = 0.0
//        audioPlayer.play()
    }
}