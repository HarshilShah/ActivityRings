//
//  ActivityRingView.swift
//  ActivityRings
//
//  Created by Harshil Shah on 14/10/17.
//  Copyright © 2017 Harshil Shah. All rights reserved.
//

import SpriteKit

public final class ActivityRingView: SKView {
    
    // MARK:- Public variables
    
    public var progress: Double {
        get { return activityRingScene.progress }
        set { activityRingScene.progress = newValue }
    }
    
    public var ringWidth: CGFloat {
        get { return activityRingScene.ringWidth }
        set { activityRingScene.ringWidth = newValue }
    }
    
    public var startColor: UIColor {
        get { return activityRingScene.startColor }
        set { activityRingScene.startColor = newValue }
    }
    
    public var endColor: UIColor {
        get { return activityRingScene.endColor }
        set { activityRingScene.endColor = newValue }
    }
    
    public var backgroundRingColor: UIColor? {
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
    
    public func animateProgress(to targetValue: Double, withDuration duration: TimeInterval) {
        activityRingScene.animateProgress(to: targetValue, withDuration: duration)
    }
    
}

