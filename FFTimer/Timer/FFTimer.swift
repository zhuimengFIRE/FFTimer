//
//  FFTimer.swift
//  NewDays
//
//  Created by FFang on 2022/3/5.
//

import Foundation
 
class FFTimer: NSObject {
    
    static let share = FFTimer()
    private var timers: [String: Timer] = [:]
    
    
    /// 开启计时器
    public func startTimer(withName name: String, interval: TimeInterval, repeats: Bool, callback: @escaping () -> Void) {
        // 停止同名的计时器
        stopTimer(withName: name)
        let timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats) { _ in
            callback()
        }
        timers[name] = timer
        RunLoop.current.add(timer, forMode: .common)
    }
    
    /// 关闭计时器
    public func stopTimer(withName name: String) {
        if let timer = timers[name] {
            timer.invalidate()
            timers[name] = nil
        }
    }
}
