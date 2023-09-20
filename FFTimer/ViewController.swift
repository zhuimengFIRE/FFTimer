//
//  ViewController.swift
//  FFTimer
//
//  Created by FFang on 2023/9/19.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    private var count: Int = 60
    private let startDate = Date()
    private let second2: CGFloat = 24*60*60
    private let second3: CGFloat = 5 * 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 60秒倒计时
        FFTimer.share.startTimer(withName: "label1", interval: 1, repeats: true) {
            self.label1.text = String(format: "%02d", self.count)
            if self.count <= 0 {
                FFTimer.share.stopTimer(withName: "label1")
            }
            self.count -= 1
        }
        
        /// 24小时倒计时
        FFTimer.share.startTimer(withName: "label2", interval: 1, repeats: true) {
            let timeElapsed = Date().timeIntervalSince(self.startDate)
            let timeRemaining = max(self.second2 - round(timeElapsed), 0)
            if timeRemaining <= 0 {
                self.label2.text = "00:00:00"
                FFTimer.share.stopTimer(withName: "label2")
            }else {
                let hours = Int(timeRemaining) / 3600
                let minutes = Int(timeRemaining) % 3600 / 60
                let seconds = Int(timeRemaining) % 60 % 60
                let timeString = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
                self.label2.text = timeString
            }
        }
        
        /// 5分钟毫秒倒计时
        FFTimer.share.startTimer(withName: "label3", interval: 0.01, repeats: true) {
            let timeElapsed = Date().timeIntervalSince(self.startDate)
            let timeRemaining = max(self.second3 - round(timeElapsed), 0)
            if timeRemaining <= 0 {
                self.label3.text = "00:00:00"
                FFTimer.share.stopTimer(withName: "label3")
            }else {
                let minutes = Int(timeRemaining) / 60
                let seconds = Int(timeRemaining) % 60
                let milliSeconds = Int((timeRemaining.truncatingRemainder(dividingBy: 1)) * 100)
                let timeString = String(format: "%02d:%02d:%02d", minutes, seconds, milliSeconds)
                self.label3.text = timeString
            }
        }
        
    }
}

