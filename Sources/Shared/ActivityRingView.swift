//
//  ActivityRingView.swift
//  ActivityRings
//
//  Created by Harshil Shah on 14/10/17.
//  Copyright © 2017 Harshil Shah. All rights reserved.
//

import SpriteKit

#if SKVIEW_AVAILABLE // excludes watchOS
public final class ActivityRingView: SKView {
    
    // MARK:- Public variables
    
    /// The progress, calculated in terms of number of revolutions of the
    /// ring. A value of 1 corresponds to one full revolution
    ///
    /// Setting this value updates the ring immediately. To animate the change,
    /// see the `animateProgress` method
    ///
    /// The default value is `0.0`
    public var progress: Double {
        get { return activityRingScene.progress }
        set { activityRingScene.progress = newValue }
    }
    
    /// The width of the activity ring
    ///
    /// The default value is `60.0`
    public var ringWidth: CGFloat {
        get { return activityRingScene.ringWidth }
        set { activityRingScene.ringWidth = newValue }
    }
    
    /// The color at the start of the ring. The alpha value is ignored while
    /// rendering
    ///
    /// The default value is `.purple`
    public var startColor: Color {
        get { return activityRingScene.startColor }
        set { activityRingScene.startColor = newValue }
    }
    
    /// The color at the end of the ring. The alpha value is ignored while
    /// rendering
    ///
    /// The default value is `.blue`
    public var endColor: Color {
        get { return activityRingScene.endColor }
        set { activityRingScene.endColor = newValue }
    }
    
    /// The color of the background ring.
    ///
    /// If a particular value isn't specified (i.e. if the value is `nil`), the
    /// background ring's color is the `startColor` with an opacity of `0.25`
    ///
    /// The default value is `nil`
    public var backgroundRingColor: Color? {
        get { return activityRingScene.backgroundRingColor }
        set { activityRingScene.backgroundRingColor = newValue }
    }
    
    // MARK:- Private variables
    
    private lazy var activityRingScene = ActivityRingScene()
    
    // MARK:- Initializers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        allowsTransparency = true
        activityRingScene.scaleMode = .resizeFill
        presentScene(activityRingScene)
    }
    
    // MARK:- Public methods
    
    /// Animates the ring's progress from its current value to a given value,
    /// with a specified animation duration
    ///
    /// The progress is calculated in terms of number of revolutions of the
    /// ring. A value of 1 corresponds to one full revolution
    ///
    /// - Parameters:
    ///   - targetValue: The desired `progress` for the ring`. This is required
    ///     to be a non-negative (0 or more) value
    ///   - duration: The duration of the progress animation, measured in
    ///     seconds. This is required to be a non-negative (0 or more) value
    public func animateProgress(to targetValue: Double, withDuration duration: TimeInterval) {
        activityRingScene.animateProgress(to: targetValue, withDuration: duration)
    }
    
}
#endif

