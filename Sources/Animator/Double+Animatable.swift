//
//  Double+Animatable.swift
//  ActivityRings
//
//  Created by Harshil Shah on 14/10/17.
//  Copyright © 2017 Harshil Shah. All rights reserved.
//

extension Double: Animatable {
    
    static func interpolate(from firstValue: Double, to secondValue: Double, withRatio ratio: Double) -> Double {
        return firstValue + (secondValue - firstValue) * ratio
    }
    
}
