//
//  Animatable.swift
//  ActivityRings
//
//  Created by Harshil Shah on 14/10/17.
//  Copyright © 2017 Harshil Shah. All rights reserved.
//

/// A protocol that describes types which can be animated / interpolated
protocol Animatable {
    
    /// Interpolates two values using a given ratio
    ///
    /// The ratio represented the proportion of the second value (i.e. `to`).
    /// So a ratio of `0` would return the starting `from` value, a ratio of `1`
    /// would return the final `to` value, and so on.
    ///
    /// - Parameters:
    ///   - firstValue: The starting value for the interpolation. This is the
    ///     value returned when the `ratio` is 0
    ///   - secondValue: The ending value for the interpolation. This is the
    ///     value returned when the `ratio` is 1
    ///   - ratio: The proportion of the interpolation
    /// - Returns: The interpolated value
    static func interpolate(from firstValue: Self, to secondValue: Self, withRatio ratio: Double) -> Self
}
