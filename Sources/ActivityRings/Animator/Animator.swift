//
//  Animator.swift
//  ActivityRings
//
//  Created by Harshil Shah on 14/10/17.
//  Copyright © 2017 Harshil Shah. All rights reserved.
//

import Foundation

struct Animator<T: Animatable> {
    
    // MARK:- Private variables
    
    private let initialValue: T
    private let targetValue: T
    private let startTime: TimeInterval
    private let duration: TimeInterval
    
    // MARK:- Initializers
    
    init(from initialValue: T, to targetValue: T, startTime: TimeInterval, duration: TimeInterval) {
        self.initialValue = initialValue
        self.targetValue  = targetValue
        self.startTime    = startTime
        self.duration     = duration
    }
    
    // MARK:- Public methods
    
    func isAnimating(at time: TimeInterval) -> Bool {
        return time <= startTime + duration
    }
    
    func value(at time: TimeInterval) -> T {
        guard isAnimating(at: time) else {
            return targetValue
        }
        
        let ratio = max(0, min(1, (time - startTime) / duration))
        let easedRatio = quadraticallyEasing(ratio)
        return T.interpolate(from: initialValue, to: targetValue, withRatio: easedRatio)
    }
    
    // MARK:- Private methods
    
    private func quadraticallyEasing(_ value: Double) -> Double {
        if value < 0.5 {
            return 2 * value * value;
        } else {
            return (-2 * value * value) + (4 * value) - 1;
        }
    }
    
}
