//
//  InterfaceController.swift
//  ActivityRings watchOS Example WatchKit Extension
//
//  Created by Cal Stephens on 10/25/18.
//  Copyright © 2018 Harshil Shah. All rights reserved.
//

import WatchKit
import Foundation
import ActivityRings_watchOS

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var smallInterfaceScene: WKInterfaceSKScene!
    @IBOutlet weak var mediumInterfaceScene: WKInterfaceSKScene!
    @IBOutlet weak var largeInterfaceScene: WKInterfaceSKScene!
    
    var sceneMapping = [WKInterfaceSKScene: ActivityRingScene]()
    
    override func willActivate() {
        sceneMapping[smallInterfaceScene]  = ActivityRingScene(size: CGSize(width: 50,  height: 50))
        sceneMapping[mediumInterfaceScene] = ActivityRingScene(size: CGSize(width: 100, height: 100))
        sceneMapping[largeInterfaceScene]  = ActivityRingScene(size: CGSize(width: 130, height: 130))
        
        for (interfaceScene, ringScene) in sceneMapping {
            interfaceScene.presentScene(ringScene)
            ringScene.animateProgress(to: 0.75, withDuration: 2.0)
            ringScene.ringWidth = 8
        }
    }

}
