//
//  DirectionalLayoutMarginsView.swift
//  iOS11NewFeatureSample
//
//  Created by pantosoft on 2017/10/16.
//  Copyright © 2017年 jianghongbing. All rights reserved.
//

import UIKit

class DirectionalLayoutMarginsView: UIView {
    private var didUpdateConstraints = false
    private var internalConstraints = [NSLayoutConstraint]()
    private lazy var brownView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brown
        addSubview(view)
        sendSubview(toBack: view)
        return view
    }()
    override func updateConstraints() {
        super.updateConstraints()
        if !didUpdateConstraints {
            if internalConstraints.count > 0 {
                NSLayoutConstraint.deactivate(internalConstraints)
                internalConstraints = []
            }
            internalConstraints = [
                NSLayoutConstraint(item: brownView, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .topMargin, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: brownView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .leftMargin, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: brownView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .rightMargin, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: brownView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1.0, constant: 0)
            ]
            NSLayoutConstraint.activate(internalConstraints)
            didUpdateConstraints = true
        }
    }
    //view的layout margin发生改变的时候,会调用该方法
    override func layoutMarginsDidChange() {
        print("layoutMarginsChanged:\(directionalLayoutMargins), \(layoutMargins)")
        didUpdateConstraints = false
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
    override var safeAreaInsets: UIEdgeInsets {
        return UIEdgeInsetsMake(30, 30, 30, 30)
    }
    
    override func safeAreaInsetsDidChange() {
        print(#line, #function, "safe area insets change:\(safeAreaInsets)")
    }
    
}
