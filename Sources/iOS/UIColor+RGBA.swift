//
//  UIColor+RGBA.swift
//  ActivityRings
//
//  Created by Harshil Shah on 01/11/17.
//  Copyright © 2017 Harshil Shah. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// Returns the red, green, blue, and alpha components
    ///
    /// Returns nil if the conversion to the RGBA colorspace wasn't successful
    var rgba: (CGFloat, CGFloat, CGFloat, CGFloat)? {
        var values: (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        let isConversionSuccessful = getRed(&values.0, green: &values.1, blue: &values.2, alpha: &values.3)
        
        guard isConversionSuccessful else {
            return nil
        }
        
        return values
    }
    
}
