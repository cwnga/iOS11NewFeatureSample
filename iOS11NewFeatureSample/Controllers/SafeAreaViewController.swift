//
//  SafeAreaViewController.swift
//  iPhoneXDemo
//
//  Created by pantosoft on 2017/9/25.
//  Copyright © 2017年 jianghongbing. All rights reserved.
//

import UIKit

class SafeAreaViewController: UIViewController {
    private var isShowStatusBar = true
    private var didUpdateConstraints = false
    private var internalConstraints = [NSLayoutConstraint]()
    private lazy var safeAreaView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.green.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 5.0
        self.view.addSubview(view)
        return view
    }()
    
    private let actionToolBar: UIToolbar = {
        let actionBar = UIToolbar()
        actionBar.translatesAutoresizingMaskIntoConstraints = false
        let hiddenOrShowStatusBarItem = UIBarButtonItem(title: "status bar", style: .plain, target: self, action:#selector(hiddenOrShowStatusBar(_:)))
        let hiddenOrShowNavigationBarItem = UIBarButtonItem(title: "navigation bar", style: .plain, target: self, action: #selector(hiddenOrShowNavigationBar(_:)))
        let hiddenOrShowTabBarItem = UIBarButtonItem(title: "tab bar", style: .plain, target: self, action: #selector(hiddenOrShowTabBar(_:)))
        let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        actionBar.setItems([hiddenOrShowStatusBarItem, flexibleSpaceItem, hiddenOrShowNavigationBarItem, flexibleSpaceItem, hiddenOrShowTabBarItem, flexibleSpaceItem], animated: true)
        return actionBar
    }()
    
    private let indicatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Show or Hidden Bars"
        return label
    }()
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        if !didUpdateConstraints {
            if internalConstraints.count > 0 {
                NSLayoutConstraint.deactivate(internalConstraints)
                internalConstraints = []
            }
            internalConstraints = [
                safeAreaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                safeAreaView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                safeAreaView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                safeAreaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                    ]
            NSLayoutConstraint.activate(internalConstraints)
            didUpdateConstraints = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Safe Area"
        view.backgroundColor = .orange
        print(view.frame, view.safeAreaLayoutGuide.layoutFrame)
        //在iOS11,已经取消了viewController的topLayoutGuide和bottomLayoutGuide,使用safe area来替代,所谓safe area指的是app的subView布局的安全范围.
        //1.状态栏,导航栏,TabBar(标签栏)都存在的情况下的safe area
        //1.1 iPhoneX:导航栏的底部到tabBar的顶部的中间的那一块区域
        //1.2 其他iPhone: 和iPhoneX的safe area区域一致
        
        //2.只有状态栏和导航栏,没有标签栏的情况
        //2.1 iPhoneX:导航栏到屏幕底部的安全区域栏(暂时不知道叫什么名字, iPhoneX的底部采用圆角的设计,其他iPhone没有这段区域)的顶部
        //2.2 其他iPhone: 导航栏到屏幕底部的区域
        
        //3.有状态栏, 没有导航栏,有或者没有标签栏
        //3.1 iPhoneX: iPhoneX的导航栏的高度已经不是20了,safe area的区域从状态栏的底部到标签栏的顶部,如果没有标签栏则到屏幕底部的安全区域
        //3.2 其他iPhone:从状态栏的底部到标签栏的顶部,或者到屏幕底部的这段区域
        
        //4.没有状态栏,有导航栏,有或者没有标签栏
        //4.1 iPhoneX:导航栏会从屏幕的顶部开始,导航栏会显的不完整,但是原本的导航栏的区域被空了出来,safe area依然是从原本的导航栏的位置开始到底部标签栏的位置,如果没有标签栏则到屏幕底部的安全区域
        //4.2 其他iPhone:会从导航栏的底部开始到标签栏的顶部,或者屏幕底部的这一段区域
        
        //5.状态栏,导航栏,标签栏都没有的时候
        //5.1 iPhoneX: 从屏幕顶部的安全区域的底部到屏幕底部的安全区域的顶部
        //5.2 其他iPhone: 整个屏幕的区域都是安全区域
        safeAreaView.addSubview(actionToolBar)
        actionToolBar.centerXAnchor.constraint(equalTo: safeAreaView.centerXAnchor).isActive = true
        actionToolBar.centerYAnchor.constraint(equalTo: safeAreaView.centerYAnchor).isActive = true
        actionToolBar.widthAnchor.constraint(equalTo: safeAreaView.widthAnchor).isActive = true
        
        safeAreaView.addSubview(indicatorLabel)
        indicatorLabel.centerXAnchor.constraint(equalTo: actionToolBar.centerXAnchor).isActive = true
        indicatorLabel.bottomAnchor.constraint(equalTo: actionToolBar.topAnchor, constant: -20).isActive = true 
    }
    
    override var prefersStatusBarHidden: Bool {
        return !isShowStatusBar
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    @objc private func hiddenOrShowStatusBar(_ barButtonItem: UIBarButtonItem) {
        isShowStatusBar = !isShowStatusBar
        setNeedsStatusBarAppearanceUpdate()
        print(view.safeAreaLayoutGuide.layoutFrame)
        didUpdateConstraints = false
        view.setNeedsUpdateConstraints()
    }
    
    @objc private func hiddenOrShowNavigationBar(_ barButtonItem: UIBarButtonItem) {
        if let isShowNavigationBar = navigationController?.navigationBar.isHidden {
            navigationController?.setNavigationBarHidden(!isShowNavigationBar, animated: true)
            print(view.safeAreaLayoutGuide.layoutFrame)
        }
        didUpdateConstraints = false
        view.setNeedsUpdateConstraints()
    }
    
    @objc private func hiddenOrShowTabBar(_ barButtonItem: UIBarButtonItem) {
        if let isShowTabBar = tabBarController?.tabBar.isHidden {
            tabBarController?.tabBar.isHidden = !isShowTabBar
        }
        didUpdateConstraints = false
        view.setNeedsUpdateConstraints()
    }
}
