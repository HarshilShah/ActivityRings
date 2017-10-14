//
//  ViewController.swift
//  ActivityRingsExample
//
//  Created by Harshil Shah on 14/10/17.
//  Copyright © 2017 Harshil Shah. All rights reserved.
//

import UIKit
import ActivityRings

class ViewController: UIViewController {
    
    private lazy var activityRingView = ActivityRingView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        activityRingView.progress = 0.75
        activityRingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityRingView)
        NSLayoutConstraint.activate([
            activityRingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityRingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityRingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            activityRingView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.activityRingView.animateProgress(to: 1.5, withDuration: 2)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
