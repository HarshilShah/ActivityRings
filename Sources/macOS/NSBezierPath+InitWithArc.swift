//
//  NSBezierPath+InitWithArc.swift
//  ActivityRings
//
//  Created by Harshil Shah on 01/11/17.
//  Copyright © 2017 Harshil Shah. All rights reserved.
//

import AppKit

extension NSBezierPath {
    
    convenience init(arcCenter center: CGPoint,
                     radius: CGFloat,
                     startAngle: CGFloat,
                     endAngle: CGFloat,
                     clockwise: Bool) {
        self.init()
        self.appendArc(withCenter: center,
                       radius: radius,
                       startAngle: startAngle * 180 / .pi,
                       endAngle: endAngle * 180 / .pi,
                       clockwise: !clockwise)
    }
    
}
