//
//  ViewController.swift
//  UIKitDynamics
//
//  Created by Kyle Wilson on 2020-04-02.
//  Copyright © 2020 Xcode Tips. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    private var animator: UIDynamicAnimator!
    private var snapping: UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        snapping = UISnapBehavior(item: imageView, snapTo: view.center)
        animator.addBehavior(snapping)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pannedView))
        imageView.addGestureRecognizer(panGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    @objc func pannedView(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animator.removeBehavior(snapping)
        case .changed:
            let translation = recognizer.translation(in: view)
            imageView.center = CGPoint(x: imageView.center.x + translation.x, y: imageView.center.y + translation.y)
            recognizer.setTranslation(.zero, in: view)
        case .ended, .cancelled, .failed:
            animator.addBehavior(snapping)
        case .possible:
            break
        @unknown default:
            fatalError()
        }
    }

}

