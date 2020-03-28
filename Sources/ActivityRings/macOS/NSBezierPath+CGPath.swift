//
//  NSBezierPath+CGPath.swift
//  ActivityRings
//
//  Created by Harshil Shah on 01/11/17.
//  Copyright © 2017 Harshil Shah. All rights reserved.
//

#if os(macOS)

import AppKit

extension NSBezierPath {
    
    /// Returns the CGPath representation of an NSBezierPath
    ///
    /// Source: https://gist.github.com/mayoff/d6d9738860ef2d0ac4055f0d12c21533#gistcomment-1931729
    public var cgPath: CGPath {
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)
        
        for i in 0 ..< self.elementCount {
            let type = self.element(at: i, associatedPoints: &points)
            
            switch type {
                
            case .moveTo:
                path.move(to: CGPoint(x: points[0].x, y: points[0].y) )
                
            case .lineTo:
                path.addLine(to: CGPoint(x: points[0].x, y: points[0].y) )
                
            case .curveTo:
                path.addCurve(to: CGPoint(x: points[2].x, y: points[2].y),
                              control1: CGPoint(x: points[0].x, y: points[0].y),
                              control2: CGPoint(x: points[1].x, y: points[1].y) )
                
            case .closePath:
                path.closeSubpath()
                
            @unknown default:
                fatalError("Unknown element \(String(describing: type)) in CGPath")
            }
        }
        return path
    }
    
}

#endif
