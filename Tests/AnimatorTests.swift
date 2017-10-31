//
//  AnimatorTests.swift
//  ActivityRings
//
//  Created by Harshil Shah on 18/10/17.
//  Copyright © 2017 Harshil Shah. All rights reserved.
//

import XCTest
@testable import ActivityRings

class AnimatorTests: XCTestCase {
    
    private var animator: Animator<Double>!
    private let now = CACurrentMediaTime()
    
    override func setUp() {
        super.setUp()
        animator = Animator(from: 0, to: 10, startTime: now, duration: 1)
    }
    
    func testIsAnimating() {
        XCTAssert(animator.isAnimating(at: now + 0.25) == true)
        XCTAssert(animator.isAnimating(at: now + 0.50) == true)
        XCTAssert(animator.isAnimating(at: now + 0.75) == true)
        XCTAssert(animator.isAnimating(at: now + 1.00) == true)
        XCTAssert(animator.isAnimating(at: now + 1.01) == false)
    }
    
    func testValues() {
        XCTAssert(animator.value(at: now + 0.25) == 1.25)
        XCTAssert(animator.value(at: now + 0.50) == 5)
        XCTAssert(animator.value(at: now + 0.75) == 8.75)
        XCTAssert(animator.value(at: now + 1.00) == 10)
        XCTAssert(animator.value(at: now + 1.01) == 10)
    }
    
    override func tearDown() {
        super.tearDown()
        animator = nil
    }
    
}
