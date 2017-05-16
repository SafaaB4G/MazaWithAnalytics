//
//  AnimationDelegate.swift
//  MazaganShowCase
//
//  Created by Nabil Alaoui on 2/11/17.
//  Copyright © 2017 B4E. All rights reserved.
//

import QuartzCore

class AnimationDelegate: NSObject, CAAnimationDelegate {
    
    fileprivate let completion: () -> Void
    
    init(completion: @escaping () -> Void) {
        self.completion = completion
    }
    
    dynamic func animationDidStop(_: CAAnimation, finished: Bool) {
        completion()
    }
}
