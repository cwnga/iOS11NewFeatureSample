//
//  NewFeatureInViewController.swift
//  iOS11NewFeatureSample
//
//  Created by pantosoft on 2017/10/13.
//  Copyright © 2017年 jianghongbing. All rights reserved.
//

import UIKit

class NewFeatureInViewController: UIViewController {
    private var isHiddenHomeIndicator = false
    private let safeAreaView: UILabel = {
        let safeAreaView = UILabel()
        safeAreaView.backgroundColor = .gray
        safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        safeAreaView.layer.borderColor = UIColor.green.cgColor
        safeAreaView.layer.borderWidth = 3.0
        safeAreaView.text = "Safa Area"
        safeAreaView.font = UIFont.systemFont(ofSize: 20)
        safeAreaView.textAlignment = .center
        return safeAreaView
    }()
    
//    private let marginView: UIView 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "printInfo", style: .plain, target: self, action: #selector(printControllerNewFeatureInfo(_:)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "showOrHideHomeIndicator", style: .plain, target: self, action: #selector(showOrHiddenHomeIndicator(_:)))
//        navigationItem.title = "new feature in UIViewController"
        //1.additionalSafeAreaInsets:额外的safeAreaInsets,在safe area区域中的view距离各个方向上额外的边距
        print("additionalSafeAreaInsets:\(additionalSafeAreaInsets)")
        additionalSafeAreaInsets = UIEdgeInsetsMake(10, 20, 30, 40)
        //2.controller的rootView的最小边距
//        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 50, leading: 50, bottom: 50, trailing: 50)
        print("systemMinimumLayoutMargins:\(systemMinimumLayoutMargins)")
        //3.是否尊敬系统给的最小的layoutMargins,默认为YES,系统会提供一个默认的layoutMargins,iphoneX:垂直方向(0.0, 16.0, 0, 16.0),水平方向上为(0.0, 20.0, 0, 20.0),布局的时候会自动在每个方向上加上对应的值,如果为false则不会加上.
        viewRespectsSystemMinimumLayoutMargins = false
        
        addSafeAreaView()
        
        //4.addGestureRecognizer
        addBottomScreenEdgesGestureRecognizer()
        
    }
    
    private func addSafeAreaView() {
        view.addSubview(safeAreaView)
        NSLayoutConstraint(item: safeAreaView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: safeAreaView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: safeAreaView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .leftMargin, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: safeAreaView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .rightMargin, multiplier: 1.0, constant: 0).isActive = true
//        safeAreaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        safeAreaView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
//        safeAreaView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
//        safeAreaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func addBottomScreenEdgesGestureRecognizer() {
        let screenEdgesGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlerGestureRecognizer(_:)))
        screenEdgesGesture.edges = .bottom
        view.addGestureRecognizer(screenEdgesGesture)
    }
    
    @objc private func handlerGestureRecognizer(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        print("swipe from bottom to top");
    }
    
    //#MARK: override
    //controller的根视图的layoutMargins发生改变的时候,会调用该方法,用于更新subview的位置等
    override func viewLayoutMarginsDidChange() {
        print(#line, #function, view.layoutMargins, view.directionalLayoutMargins, systemMinimumLayoutMargins)
    }
    //controller的根视图的safe area inset发生改变的时候,会调用该方法.用于更新界面适应于新的safe area
    override func viewSafeAreaInsetsDidChange() {
        print(#line, #function, view.safeAreaInsets)
    }
    
    @objc private func printControllerNewFeatureInfo(_ barButtonItem: UIBarButtonItem) {
        print("additionalSafeAreaInsets:\(additionalSafeAreaInsets)")
        print("systemMinimumLayoutMargins:\(systemMinimumLayoutMargins)")
    }
    
    @objc private func showOrHiddenHomeIndicator(_ barButtonItem: UIBarButtonItem) {
        isHiddenHomeIndicator = !isHiddenHomeIndicator
        //3.更新home indicator状态
        setNeedsUpdateOfHomeIndicatorAutoHidden()
    }
    
    //#MARK: 是否自动隐藏屏幕上面的感应器,如果为ture,几秒后,会隐藏该显示器
    override func prefersHomeIndicatorAutoHidden() -> Bool {
        return isHiddenHomeIndicator
    }
    
    //当controller为一个容器控制器(如UINavigationController),可重写该方法,返回一个控制器,这个控制器的home indicator状态,将作为容器控制器内部所有控制器的home indicator的状态的参考,用于统一设置容器控制器里面的所有控制器home indicator的状态,如果返回nil,则将home indicator的状态的控制权,交给当前控制器
    override func childViewControllerForHomeIndicatorAutoHidden() -> UIViewController? {
        return nil
    }
    
    //#MARK:延迟系统手势响应. 默认情况下,系统定义的手势的优先级都会高于app内部定义的手势的优先级(如从屏幕的上方下滑,弹出通知中心,而不会去响应app内部定义的手势),iOS11之后可以通过该方法来指定app内部定义的手势的优先级高于系统的(尽量不要这么做,苹果文档里面说的)
    override func preferredScreenEdgesDeferringSystemGestures() -> UIRectEdge {
        return .bottom
    }
    
    //统一设置容器控制器里面的所有控制器的视图的手势优先级.如果返回nil,则将该控制权交给容器控制器里面的当前控制器
    override func childViewControllerForScreenEdgesDeferringSystemGestures() -> UIViewController? {
        return nil
    }
    
}
