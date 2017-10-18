//
//  MarginTestView.swift
//  iOS11NewFeatureSample
//
//  Created by pantosoft on 2017/10/17.
//  Copyright © 2017年 jianghongbing. All rights reserved.
//

import UIKit

class MarginTestView: UIView {
    private var didUpdateConstraints = false
    private var internalConstraints = [NSLayoutConstraint]()
    private lazy var blueView: UIView = {
        let blueView = UIView()
        blueView.translatesAutoresizingMaskIntoConstraints = false
        blueView.backgroundColor = .blue
        addSubview(blueView)
        
        let orangeView = UIView()
        orangeView.translatesAutoresizingMaskIntoConstraints = false
        orangeView.backgroundColor = .orange
        blueView.addSubview(orangeView)
        
//        NSLayoutConstraint.constraints(withVisualFormat: <#T##String#>, options: <#T##NSLayoutFormatOptions#>, metrics: <#T##[String : Any]?#>, views: <#T##[String : Any]#>)
        
        return blueView
    }()
    
    
    override var preservesSuperviewLayoutMargins: Bool {
        set {
            super.preservesSuperviewLayoutMargins = newValue
            _updateConstraints()
        }
        
        get {
           return super.preservesSuperviewLayoutMargins
        }
    }
    
    override func layoutMarginsDidChange() {
        _updateConstraints()
    }
    
    
    
    private func _updateConstraints() {
        didUpdateConstraints = false
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !didUpdateConstraints {
            if internalConstraints.count > 0 {
                NSLayoutConstraint.deactivate(internalConstraints)
                internalConstraints = []
            }
            let margin:CGFloat = 10.0
            internalConstraints = [
                blueView.topAnchor.constraint(equalTo: topAnchor, constant: margin),
                blueView.leftAnchor.constraint(equalTo: leftAnchor, constant: margin),
                blueView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin),
                blueView.rightAnchor.constraint(equalTo: rightAnchor, constant: -margin)
                ]
            NSLayoutConstraint.activate(internalConstraints)
            didUpdateConstraints = true
        }
    }
    
}
