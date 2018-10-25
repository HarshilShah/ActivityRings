//
//  ActivityRingScene.swift
//  ActivityRings
//
//  Created by Harshil Shah on 14/10/17.
//  Copyright © 2017 Harshil Shah. All rights reserved.
//

import SpriteKit

public final class ActivityRingScene: SKScene {
    
    // MARK:- Constants
    
    private let backgroundRingAlpha: CGFloat = 0.25
    
    // MARK:- Public variables
    
    public var progress: Double = 0 {
        didSet { isUpdateNeeded = true }
    }
    
    public var ringWidth: CGFloat = 60 {
        didSet { isUpdateNeeded = true }
    }
    
    public var startColor = Color.purple {
        didSet { isUpdateNeeded = true }
    }
    
    public var endColor = Color.blue {
        didSet { isUpdateNeeded = true }
    }
    
    public var backgroundRingColor: Color? {
        didSet { isUpdateNeeded = true }
    }
    
    // MARK:- Private variables
    
    private var animator: Animator<Double>?
    
    private var isUpdateNeeded = false
    
    private var isAnimating: Bool {
        guard let animator = animator else {
            return false
        }
        
        return animator.isAnimating(at: CACurrentMediaTime())
    }
    
    // MARK: Nodes
    
    private lazy var backgroundRingNode = SKShapeNode()
    private lazy var shadowNode = SKEffectNode()
    private lazy var shadowShapeNode = SKShapeNode()
    private lazy var solidArcNode = SKShapeNode()
    private lazy var gradientCropNode = SKCropNode()
    private lazy var unshadedArcNode = SKShapeNode()
    private lazy var gradientArcNode = SKShapeNode()
    
    // MARK:- Initialization/setup
    
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
    public override func sceneDidLoad() {
        super.sceneDidLoad()
        setup()
    }
    
    #if SKVIEW_AVAILABLE // excludes watchOS
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, *) {
            /// Nothing to do; this is a fallback for `sceneDidLoad` since that
            /// doesn't exist on iOS <10.0 and macOS <10.12 and tvOS <10.0
        } else {
            setup()
        }
    }
    #endif
    
    private func setup() {
        backgroundColor = .clear
        
        backgroundRingNode.lineCap = .round
        addChild(backgroundRingNode)
        
        solidArcNode.lineCap = .round
        addChild(solidArcNode)
        
        addChild(shadowNode)
        shadowShapeNode.lineCap = .round
        shadowNode.addChild(shadowShapeNode)
        
        /// This shader simply sets the color at any point to be a mixture of the
        /// `start_color` and `end_colors` in the same proportion as it's distance from
        /// each end
        ///
        /// The `end_color` represents the color at the end of a full revolution,
        /// so for cases when the progress is under a full revolution (i.e. <1), the
        /// actual line never is of that color. So a `progress` uniform is used to
        /// adjust the proportional distance of a point from the end of a full
        /// revolution
        let ringShader = SKShader(source: """
            void main() {
                float ratio = progress * v_path_distance / u_path_length;
                gl_FragColor = vec4((start_color * (1.0 - ratio)) + (end_color * ratio), 1.0);
            }
        """)
        
        gradientArcNode.strokeShader = ringShader
        gradientArcNode.lineCap = .round
        
        unshadedArcNode.lineCap = .round
        gradientCropNode.maskNode = unshadedArcNode
        gradientCropNode.maskNode = unshadedArcNode
        gradientCropNode.addChild(gradientArcNode)
        addChild(gradientCropNode)
        
        updateColors(forProgress: getProgress())
    }
    
    // MARK:- SKScene methods
    
    public override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        guard isAnimating || isUpdateNeeded else {
            return
        }
        
        isUpdateNeeded = false
        
        let progress = getProgress(atTime: currentTime)
        updateColors(forProgress: progress)
        updateLayout(forProgress: progress)
    }
    
    public override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        isUpdateNeeded = true
    }
    
    // MARK:- Public methods
    
    public func animateProgress(to targetValue: Double, withDuration duration: TimeInterval) {
        guard targetValue >= 0, duration >= 0 else {
            return
        }
        
        let now = CACurrentMediaTime()
        animator = Animator(from: getProgress(atTime: now),
                            to: targetValue,
                            startTime: now,
                            duration: duration)
    }
    
    // MARK:- Private methods
    
    private func getProgress(atTime time: TimeInterval = CACurrentMediaTime()) -> Double {
        guard let animator = animator else {
            return progress
        }
        
        return animator.value(at: time)
    }
    
    private func updateLayout(forProgress progress: Double) {
        let progress = CGFloat(progress)
        let center = CGPoint(x: size.width/2, y: size.height/2)
        let radius = (min(size.width, size.height) / 2) - (ringWidth/2)
        
        let angleOffset = CGFloat.pi / 2
        let angle = (2 * .pi * progress) - angleOffset
        let minAngle = 1.1 * atan(0.5 * ringWidth / radius)
        let maxAngle = 2 * .pi - 3 * minAngle - angleOffset
        
        /// Multiplying angles by -1 because SpriteKit
        ///
        /// NOTE:- Clockwise means anticlockwise in SpriteKit for iOS
        /// Clockwise means clockwise in macOS, however, so the clockwise
        /// variable is flipped in that method
        
        let gradientOffset = max(angle - maxAngle, 0) * -1
        let gradientAngle = min(angle, maxAngle) * -1
        
        /// Best as I can tell there's no way to generate a perfect circular arc
        /// with just the center and radius that works in both UIKit and AppKit
        backgroundRingNode.path = {
            if #available(macOS 10.10, *) {
                return BezierPath(arcCenter: center, radius: radius,
                                  startAngle: 0, endAngle: 2 * .pi,
                                  clockwise: true).cgPath
            } else {
                return BezierPath(arcCenter: center, radius: radius,
                                  startAngle: 0, endAngle: 2 * .pi,
                                  clockwise: false).cgPath
            }
        }()
        
        solidArcNode.path = {
            guard angle > maxAngle else {
                return BezierPath(arcCenter: center, radius: radius,
                                  startAngle: angleOffset,
                                  endAngle: angleOffset,
                                  clockwise: false).cgPath
            }
            return BezierPath(arcCenter: center, radius: radius,
                              startAngle: angleOffset,
                              endAngle: gradientOffset,
                              clockwise: false).cgPath
        }()
        
        shadowShapeNode.path = {
            guard progress != 0 else { return nil }
            return BezierPath(arcCenter: center, radius: radius,
                              startAngle: gradientAngle + gradientOffset + min(progress/2, 0.06),
                              endAngle: gradientAngle + gradientOffset - 0.03,
                              clockwise: false).cgPath
        }()
        
        gradientArcNode.path = {
            guard progress != 0 else { return nil }
            return BezierPath(arcCenter: center, radius: radius,
                              startAngle: angleOffset + gradientOffset,
                              endAngle: gradientAngle + gradientOffset,
                              clockwise: false).cgPath
        }()
        
        unshadedArcNode.path = gradientArcNode.path
        
        backgroundRingNode.lineWidth = ringWidth
        solidArcNode.lineWidth = ringWidth
        shadowShapeNode.lineWidth = ringWidth
        gradientArcNode.lineWidth = ringWidth
        unshadedArcNode.lineWidth = ringWidth
        
        #if canImport(CoreImage)
        let shadowRadius = NSNumber(value: ceil(0.3 * Double(ringWidth)))
        let shadowAngle = NSNumber(value: Double(gradientAngle + gradientOffset + .pi/2))
        
        shadowNode.filter = CIFilter(
            name: "CIMotionBlur",
            parameters: ["inputRadius": shadowRadius,
                         "inputAngle" : shadowAngle])
        #endif
    }
    
    private func updateColors(forProgress progress: Double) {
        backgroundRingNode.strokeColor = backgroundRingColor ?? startColor.withAlphaComponent(backgroundRingAlpha)
        solidArcNode.strokeColor = startColor
        
        let shadowAlpha = CGFloat(min(1, progress))
        shadowShapeNode.strokeColor = Color.black.withAlphaComponent(shadowAlpha)
        
        guard let startRGBA = startColor.rgba, let endRGBA = endColor.rgba else {
            return
        }
        
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 4.0, *) {
            gradientArcNode.strokeShader?.uniforms = [
                SKUniform(name: "progress",    float: min(Float(progress), 1)),
                SKUniform(name: "start_color", vectorFloat3: vector3(Float(startRGBA.0), Float(startRGBA.1), Float(startRGBA.2))),
                SKUniform(name: "end_color",   vectorFloat3: vector3(Float(endRGBA.0),   Float(endRGBA.1),   Float(endRGBA.2)))
            ]
        } else {
            #if canImport(GLKit)
            gradientArcNode.strokeShader?.uniforms = [
                SKUniform(name: "progress",    float: min(Float(progress), 1)),
                SKUniform(name: "start_color", float: GLKVector3(v: (Float(startRGBA.0), Float(startRGBA.1), Float(startRGBA.2)))),
                SKUniform(name: "end_color",   float: GLKVector3(v: (Float(endRGBA.0),   Float(endRGBA.1),   Float(endRGBA.2))))
            ]
            #else
            fatalError("No available `strokeShader` API.")
            #endif
        }
        
    }
    
}
