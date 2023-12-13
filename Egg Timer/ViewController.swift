//
//  ViewController.swift
//  Egg Timer
//
//  Created by Kitty Mork on 2023-11-25.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var controlButton: UIButton!
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {

        clearTimer()
        let hardness = sender.titleLabel?.text
        totalTime = eggTimes[hardness!]!
        
        startTimer()
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            
            progressBar.progress = percentageProgress
            
            secondsPassed += 1
        } else {
            titleLabel.text = "Done!"
//          progressBar.isHidden = true
            playSound()
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        clearTimer()
    }
    
    
    @IBAction func controlButtonPressed(_ sender: UIButton) {
        if controlButton.titleLabel?.text == "Pause"
        {
            pauseTimer()
            controlButton.setTitle("Resume", for: .normal)
        }
        else if controlButton.titleLabel?.text == "Resume" {
            startTimer()
            controlButton.setTitle("Pause", for: .normal)
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func clearTimer() {
        timer.invalidate()
        progressBar.progress = 0.0
        secondsPassed = 0
    }
    
    func pauseTimer() {
        timer.invalidate()
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}

