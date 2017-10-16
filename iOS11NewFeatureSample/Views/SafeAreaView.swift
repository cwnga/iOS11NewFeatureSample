//
//  SafeAreaView.swift
//  iOS11NewFeatureSample
//
//  Created by pantosoft on 2017/10/16.
//  Copyright © 2017年 jianghongbing. All rights reserved.
//

import UIKit

class SafeAreaView: UIView {
    private var didUpdateLayoutConstraints = false
    private var internalConstraints = [NSLayoutConstraint]()
    
    private lazy var subView: UIView = {
        let blueView = UIView()
        blueView.translatesAutoresizingMaskIntoConstraints = false
        blueView.backgroundColor = .blue
        addSubview(blueView)
        sendSubview(toBack: blueView)
        return blueView
    }()
    
    //1.当safeAreaInset发生改变的时候,会调用该方法
    override func safeAreaInsetsDidChange() {
        print(#line, #function, "safe area insets change:\(safeAreaInsets)")
        didUpdateLayoutConstraints = false
        setNeedsUpdateConstraints()
    }
    override func updateConstraints() {
        super.updateConstraints()
        if !didUpdateLayoutConstraints {
            if internalConstraints.count > 0 {
                NSLayoutConstraint.deactivate(internalConstraints)
                internalConstraints = []
            }
            internalConstraints = [
                subView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                subView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
                subView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
                subView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ]
            NSLayoutConstraint.activate(internalConstraints)
        }
    }
    
    override var safeAreaInsets: UIEdgeInsets {
        return UIEdgeInsetsMake(10, 20, 30, 20)
    }
    
}
