//
//  BarsHeightViewController.swift
//  iOS11NewFeatureSample
//
//  Created by pantosoft on 2017/10/11.
//  Copyright © 2017年 jianghongbing. All rights reserved.
//

import UIKit

class BarsHeightViewController: UIViewController {
    private lazy var statusBarInfoLabel: UILabel = {
        return BarsHeightViewController.makeLabel()
    }()
    
    private lazy var navigationBarInfoLabel: UILabel = {
        return BarsHeightViewController.makeLabel()
    }()

    private lazy var toolBarInfoLabel: UILabel = {
        return BarsHeightViewController.makeLabel()
    }()

    private lazy var tabBarInfoLabel: UILabel = {
        return BarsHeightViewController.makeLabel()
    }()
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [statusBarInfoLabel, navigationBarInfoLabel, toolBarInfoLabel, tabBarInfoLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(screenRotated(_:)), name: .UIDeviceOrientationDidChange, object: UIDevice.current)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        reloadBarsFrameInfo()
    }
    
    @objc private func screenRotated(_ notification: Notification) {
        reloadBarsFrameInfo()
    }

    private func reloadBarsFrameInfo() {
        statusBarInfoLabel.text = "statusBar:\(UIApplication.shared.statusBarFrame)"
        if let navigationBar = navigationController?.navigationBar {
            navigationBarInfoLabel.text = "navigationBar:\(navigationBar.frame)"
        }else {
            navigationBarInfoLabel.text = "no navigation bar"
        }
        if let toolBar = navigationController?.toolbar {
            toolBarInfoLabel.text = "toolBar:\(toolBar.frame)"
        }else {
            toolBarInfoLabel.text = "no tool bar"
        }
        if let tabBar = tabBarController?.tabBar {
            tabBarInfoLabel.text = "tabBar:\(tabBar.frame)"
        }else {
            tabBarInfoLabel.text = "no tab bar"
        }
    }
    
    private class func makeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
