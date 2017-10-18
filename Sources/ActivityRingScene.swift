//
//  ActivityRingScene.swift
//  ActivityRings
//
//  Created by Harshil Shah on 14/10/17.
//  Copyright © 2017 Harshil Shah. All rights reserved.
//

import SpriteKit

final class ActivityRingScene: SKScene {
    
    // MARK:- Constants
    
    private let backgroundRingAlpha: CGFloat = 0.25
    
    // MARK:- Public variables
    
    var progress: Double = 0 {
        didSet { isUpdateNeeded = true }
    }
    
    var ringWidth: CGFloat = 60 {
        didSet { isUpdateNeeded = true }
    }
    
    var startColor = UIColor.purple {
        didSet { isUpdateNeeded = true }
    }
    
    var endColor = UIColor.blue {
        didSet { isUpdateNeeded = true }
    }
    
    var backgroundRingColor: UIColor? {
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
    private lazy var gradientArcNode = SKShapeNode()
    
    // MARK:- Initialization/setup
    
    @available(iOS 10.0, *)
    override func sceneDidLoad() {
        super.sceneDidLoad()
        setup()
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        if #available(iOS 10.0, *) {
            /// Nothing to do; this is a fallback for `sceneDidLoad` since that
            /// doesn't exist on iOS <10
        } else {
            setup()
        }
    }
    
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
        addChild(gradientArcNode)
        
        updateColors(forProgress: getProgress())
    }
    
    // MARK:- SKScene methods
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        guard isAnimating || isUpdateNeeded else {
            return
        }
        
        isUpdateNeeded = false
        
        let progress = getProgress(atTime: currentTime)
        updateColors(forProgress: progress)
        updateLayout(forProgress: progress)
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        isUpdateNeeded = true
    }
    
    // MARK:- Public methods
    
    func animateProgress(to targetValue: Double, withDuration duration: TimeInterval) {
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
        
        // Multiplying angles by -1 because SpriteKit
        // NOTE:- Clockwise means anticlockwise in SpriteKit
        
        let gradientOffset = max(angle - maxAngle, 0) * -1
        let gradientAngle = min(angle, maxAngle) * -1
        
        backgroundRingNode.path = UIBezierPath(arcCenter: center, radius: radius,
                                               startAngle: 0,
                                               endAngle: 2 * .pi,
                                               clockwise: false).cgPath
        
        solidArcNode.path = {
            guard angle > maxAngle else {
                return UIBezierPath(arcCenter: center, radius: radius,
                                    startAngle: angleOffset,
                                    endAngle: angleOffset,
                                    clockwise: false).cgPath
            }
            return UIBezierPath(arcCenter: center, radius: radius,
                                startAngle: angleOffset,
                                endAngle: gradientOffset,
                                clockwise: false).cgPath
        }()
        
        shadowShapeNode.path = {
            guard progress != 0 else { return nil }
            return UIBezierPath(arcCenter: center, radius: radius,
                                startAngle: gradientAngle + gradientOffset + min(progress/2, 0.06),
                                endAngle: gradientAngle + gradientOffset - 0.03,
                                clockwise: false).cgPath
        }()
        
        gradientArcNode.path = {
            guard progress != 0 else { return nil }
            return UIBezierPath(arcCenter: center, radius: radius,
                                startAngle: angleOffset + gradientOffset,
                                endAngle: gradientAngle + gradientOffset,
                                clockwise: false).cgPath
        }()
        
        backgroundRingNode.lineWidth = ringWidth
        solidArcNode.lineWidth = ringWidth
        shadowShapeNode.lineWidth = ringWidth
        gradientArcNode.lineWidth = ringWidth
        
        let shadowRadius = NSNumber(value: ceil(0.3 * Double(ringWidth)))
        let shadowAngle = NSNumber(value: Double(gradientAngle + gradientOffset + .pi/2))
        shadowNode.filter = CIFilter(
            name: "CIMotionBlur",
            withInputParameters: ["inputRadius": shadowRadius,
                                  "inputAngle" : shadowAngle])
    }
    
    private func updateColors(forProgress progress: Double) {
        backgroundRingNode.strokeColor = backgroundRingColor ?? startColor.withAlphaComponent(backgroundRingAlpha)
        solidArcNode.strokeColor = startColor
        
        let shadowAlpha = CGFloat(min(1, progress))
        shadowShapeNode.strokeColor = UIColor.black.withAlphaComponent(shadowAlpha)
        
        var startRGB: (CGFloat, CGFloat, CGFloat) = (0, 0, 0)
        var endRGB: (CGFloat, CGFloat, CGFloat)   = (0, 0, 0)
        
        let isStartConversionSuccess = startColor.getRed(&startRGB.0, green: &startRGB.1, blue: &startRGB.2, alpha: nil)
        let isEndConversionSuccess   = endColor.getRed(&endRGB.0, green: &endRGB.1, blue: &endRGB.2, alpha: nil)
        
        if isStartConversionSuccess && isEndConversionSuccess {
            if #available(iOS 10.0, *) {
                gradientArcNode.strokeShader?.uniforms = [
                    SKUniform(name: "progress",    float: min(Float(progress), 1)),
                    SKUniform(name: "start_color", vectorFloat3: vector3(Float(startRGB.0), Float(startRGB.1), Float(startRGB.2))),
                    SKUniform(name: "end_color",   vectorFloat3: vector3(Float(endRGB.0),   Float(endRGB.1),   Float(endRGB.2)))
                ]
            } else {
                gradientArcNode.strokeShader?.uniforms = [
                    SKUniform(name: "progress",    float: min(Float(progress), 1)),
                    SKUniform(name: "start_color", float: GLKVector3(v: (Float(startRGB.0), Float(startRGB.1), Float(startRGB.2)))),
                    SKUniform(name: "end_color",   float: GLKVector3(v: (Float(endRGB.0),   Float(endRGB.1),   Float(endRGB.2))))
                ]
            }
        }
        
    }
    
}

