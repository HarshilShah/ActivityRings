//
//  Typealias.swift
//  ActivityRings
//
//  Created by Harshil Shah on 01/11/17.
//  Copyright © 2017 Harshil Shah. All rights reserved.
//

import SpriteKit

#if os(macOS)
    
    public typealias Color = NSColor
    public typealias BezierPath = NSBezierPath

#else

    public typealias Color = UIColor
    public typealias BezierPath = UIBezierPath
    
#endif
