//
//  LayoutMarginsView.swift
//  iOS11NewFeatureSample
//
//  Created by pantosoft on 2017/10/16.
//  Copyright © 2017年 jianghongbing. All rights reserved.
//

import UIKit

class LayoutMarginsView: UIView {
    private var didUpdateConstraints = false
    private var internalConstraints = [NSLayoutConstraint]()
    private lazy var marginView: UIView = {
        let redView = UIView()
        redView.translatesAutoresizingMaskIntoConstraints = false 
        redView.backgroundColor = .red
        addSubview(redView)
        sendSubview(toBack: redView)
        return redView
    }()
    
    override func updateConstraints() {
        super.updateConstraints()
        if !didUpdateConstraints {
            if internalConstraints.count > 0 {
                NSLayoutConstraint.deactivate(internalConstraints)
                internalConstraints = []
            }
           internalConstraints = [
            NSLayoutConstraint(item: marginView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: marginView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .leftMargin, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: marginView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .rightMargin, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: marginView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1.0, constant: 0)
            ]
            NSLayoutConstraint.activate(internalConstraints)
            didUpdateConstraints = true
        }
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        fatalError("do not support this method to init")
//    }
//
//    init(layoutMargins: UIEdgeInsets) {
//        super.init(frame: .zero)
//        preservesSuperviewLayoutMargins = true
//        self.layoutMargins = layoutMargins
//    }
    
    //view的layout margin发生改变的时候,会调用该方法
    override func layoutMarginsDidChange() {
        print("layoutMarginsChanged:\(layoutMargins)")
        didUpdateConstraints = false
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
}
