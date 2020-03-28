//
//  NSColor+RGBA.swift
//  ActivityRings
//
//  Created by Harshil Shah on 01/11/17.
//  Copyright © 2017 Harshil Shah. All rights reserved.
//

#if os(macOS)

import AppKit

extension NSColor {
    
    /// Returns the red, green, blue, and alpha components
    ///
    /// This never returns nil; the returntype is optional purely for
    /// consistency with the UIColor API
    ///
    /// This raises an exception if the conversion to an RGBA colorspace wasn't
    /// successful
    var rgba: (CGFloat, CGFloat, CGFloat, CGFloat)? {
        var values: (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        getRed(&values.0, green: &values.1, blue: &values.2, alpha: &values.3)
        return values
    }
    
}

#endif
