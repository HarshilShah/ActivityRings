//
//  ViewController.swift
//  ActivityRings macOS Example
//
//  Created by Harshil Shah on 01/11/17.
//  Copyright © 2017 Harshil Shah. All rights reserved.
//

import Cocoa
import ActivityRings

class ViewController: NSViewController {

    private lazy var activityRingView = ActivityRingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityRingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityRingView)
        NSLayoutConstraint.activate([
            activityRingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityRingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityRingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            activityRingView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9),
        ])
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.activityRingView.animateProgress(to: 1, withDuration: 3)
        }
    }

}

