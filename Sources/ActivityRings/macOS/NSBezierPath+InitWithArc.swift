//
//  NSBezierPath+InitWithArc.swift
//  ActivityRings
//
//  Created by Harshil Shah on 01/11/17.
//  Copyright © 2017 Harshil Shah. All rights reserved.
//

#if os(macOS)

import AppKit

extension NSBezierPath {
    
    /// Initialises an NSBezierPath with an arc of a circle. This is meant to
    /// mimic the corresponding UIBezierPath API, for use in SpriteKit, and so
    /// it does not conform strictly to any of the three's conventions.
    ///
    /// The angle accepted is in radians, whereas AppKit expects degrees
    ///
    /// The clockwise direction is also negated whike rendering, because
    /// while SpriteKit renders opposite to UIKit expectations because of the
    /// flipped co-ordinate space, requiring passing `true` for `false` and vice
    /// versa, it follows AppKit's expectations. However this library is
    /// UIKit-first, so flipping the direction is required.
    ///
    /// - Parameters:
    ///   - center: The center of the circle
    ///   - radius: The radius of the circle
    ///   - startAngle: The starting angle for the arc, in radians
    ///   - endAngle: The ending angle for the arc, in radians
    ///   - clockwise: Whether the arc should
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

#endif
