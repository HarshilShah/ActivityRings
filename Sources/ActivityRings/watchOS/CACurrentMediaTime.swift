//
//  CACurrentMediaTime.swift
//  ActivityRings watchOS
//
//  Created by Cal Stephens on 10/17/18.
//  Copyright © 2018 Harshil Shah. All rights reserved.
//

#if os(watchOS)

// watchOS doesn't have CoreAnimation,
// so we need to create our own implementation of `CACurrentMediaTime`.

import Foundation

fileprivate var cached_mach_timebase_info = mach_timebase_info_data_t()

func CACurrentMediaTime() -> CFTimeInterval {
    
    // retrieve the `mach_timebase_info` if it hasn't been retreived yet
    if cached_mach_timebase_info.numer == mach_timebase_info_data_t().numer
        && cached_mach_timebase_info.numer == mach_timebase_info_data_t().denom
    {
        mach_timebase_info(&cached_mach_timebase_info)
    }
    
    let nanos = Double(mach_absolute_time() * UInt64(cached_mach_timebase_info.numer)) / Double(cached_mach_timebase_info.denom)
    return nanos / 1.0e9;
}

#endif
