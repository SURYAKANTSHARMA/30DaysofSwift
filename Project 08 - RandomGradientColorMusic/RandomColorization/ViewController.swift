//
//  ViewController.swift
//  RandomColorization
//
//  Created by Allen on 16/1/14.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var audioPlayer = AVAudioPlayer()
    
    let gradientLayer = CAGradientLayer()

    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isStatusBarHidden =  true
    }
    
    @IBAction func playMusicButtonDidTouch(_ sender: AnyObject) {
        
        //play bg music
        let omMusicUrl = Bundle.main.url(forResource: "Om Dhawni", withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: omMusicUrl!)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            audioPlayer.delegate = self
        }  catch {
            print(error.localizedDescription)
        }
        
        if (timer == nil) {
            timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(ViewController.randomColor), userInfo: nil, repeats: true)
        }
        
        let redValue = CGFloat(drand48())
        let blueValue =  CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        
        self.view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
        //graditent color
        gradientLayer.frame = view.bounds
        let color1 = UIColor(white: 0.5, alpha: 0.2).cgColor as CGColor
        let color2 = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.4).cgColor as CGColor
        let color3 = UIColor(red: 0, green: 1, blue: 0, alpha: 0.3).cgColor as CGColor
        let color4 = UIColor(red: 0, green: 0, blue: 1, alpha: 0.3).cgColor as CGColor
        let color5 = UIColor(white: 0.4, alpha: 0.2).cgColor as CGColor
        
        gradientLayer.colors = [color1, color2, color3, color4, color5]
        gradientLayer.locations = [0.10, 0.30, 0.50, 0.70, 0.90]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
      
        self.view.layer.addSublayer(gradientLayer)
        
    }
    
    @IBAction func stopBarButtonTapped(_ sender: UIBarButtonItem) {
        audioPlayer.stop()
        timer?.invalidate()
        timer = nil
        view.backgroundColor = UIColor(red: 33/255, green: 0, blue: 114/255, alpha: 1.0)
        gradientLayer.removeFromSuperlayer()
        
    }
    
    @IBAction func replyBarButtonTapped(_ sender: UIBarButtonItem) {
        if audioPlayer.isPlaying {
            audioPlayer.stop()
        }
        playMusicButtonDidTouch(UIButton())
    }
    
    func randomColor() {
        
        let redValue = CGFloat(drand48())
        let blueValue =  CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        
        
        self.view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playMusicButtonDidTouch(UIButton())
    }

}

