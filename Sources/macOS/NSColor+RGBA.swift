//
//  NSColor+RGBA.swift
//  ActivityRings
//
//  Created by Harshil Shah on 01/11/17.
//  Copyright © 2017 Harshil Shah. All rights reserved.
//

import AppKit

extension NSColor {
    
    var rgba: (CGFloat, CGFloat, CGFloat, CGFloat)? {
        var values: (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        getRed(&values.0, green: &values.1, blue: &values.2, alpha: &values.3)
        return values
    }
    
}
