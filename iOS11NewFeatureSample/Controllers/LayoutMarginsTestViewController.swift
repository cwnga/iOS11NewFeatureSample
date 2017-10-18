//
//  LayoutMarginsTestViewController.swift
//  iOS11NewFeatureSample
//
//  Created by pantosoft on 2017/10/17.
//  Copyright © 2017年 jianghongbing. All rights reserved.
//

import UIKit

class LayoutMarginsTestViewController: UIViewController {
    private lazy var topView: UIView = {
        let topView = createView(withBackgroundColor: .red)
        topView.layoutMargins = UIEdgeInsetsMake(10, 20, 30, 40)
        return topView
    }()
    
    private lazy var bottomView: UIView = {
       return createView(withBackgroundColor: .orange)
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topView, bottomView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
        view.addSubview(stackView)
        return stackView
    }()
    
    private func createView(withBackgroundColor backgroundColor: UIColor) -> UIView {
        let createView = UIView()
        createView.translatesAutoresizingMaskIntoConstraints = false
        createView.backgroundColor = backgroundColor
        return createView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.layoutMargins = UIEdgeInsetsMake(-50, 20, -100, 40)
        view.insetsLayoutMarginsFromSafeArea = true
        
        
//        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//        stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: -100).isActive = true
        NSLayoutConstraint(item: stackView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .leftMargin, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: stackView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .rightMargin, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1.0, constant: 0).isActive = true
        
        //1.preservesSuperviewLayoutMargins:是否保护super的layout margins,默认为false.如果该view使用auto layout来布局,且没有使用带margin的相关attribute来布局,如果该view的subview使用了带margin的相关attribute来进行布局,如果layoutmargin的值小于super view的layoutmargin的值,将会使用该view的super view的layout margins来进行布局,如果layoutMargin的值大于super view的layout margin的值,这按照自己的layoutMargin来布局.如果为false,这不会保护super view的layout margin区域,会使用自己的layout margin来进行布局
        //2.insetsLayoutMarginsFromSafeArea:view的layoutMargin是否从safe area开始,就是保护safe area区域,让内容显示在safe area区域中,默认为true.当view的layoutMargin有对应方向上的值小于0的情况,并且是通过margin相关属性来进行布局,系统会忽略小于0的值,直接从safe area区域开始布局,也就是不让subView超出safe area区域,如果为flase,则按照不会忽略小于0的数值,可以让subView的内容超出safe area区域
        topViewAddSubviews()
    }
    
    private func topViewAddSubviews() {
        let topViewSubview = UIView()
//        topViewSubview.layoutMargins = UIEdgeInsetsMake(50, 50, 50, 50)
        topViewSubview.layoutMargins = .zero
        topViewSubview.translatesAutoresizingMaskIntoConstraints = false
        topViewSubview.preservesSuperviewLayoutMargins = true
        topViewSubview.backgroundColor = .blue
        topView.addSubview(topViewSubview)
        NSLayoutConstraint(item: topViewSubview, attribute: .top, relatedBy: .equal, toItem: topView, attribute: .topMargin, multiplier: 1.0, constant: 5).isActive = true
        NSLayoutConstraint(item: topViewSubview, attribute: .left, relatedBy: .equal, toItem: topView, attribute: .left, multiplier: 1.0, constant: 5).isActive = true
        NSLayoutConstraint(item: topViewSubview, attribute: .right, relatedBy: .equal, toItem: topView, attribute: .right, multiplier: 1.0, constant: -5).isActive = true
        NSLayoutConstraint(item: topViewSubview, attribute: .bottom, relatedBy: .equal, toItem: topView, attribute: .bottom, multiplier: 1.0, constant: -5).isActive = true
        
        let orangeView = UIView()
        orangeView.translatesAutoresizingMaskIntoConstraints = false
        orangeView.backgroundColor = .orange
        topViewSubview.addSubview(orangeView)
        
        NSLayoutConstraint(item: orangeView, attribute: .top, relatedBy: .equal, toItem: topViewSubview, attribute: .topMargin, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: orangeView, attribute: .left, relatedBy: .equal, toItem: topViewSubview, attribute: .leftMargin, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: orangeView, attribute: .right, relatedBy: .equal, toItem: topViewSubview, attribute: .rightMargin, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: orangeView, attribute: .bottom, relatedBy: .equal, toItem: topViewSubview, attribute: .bottomMargin, multiplier: 1.0, constant: 0).isActive = true
    }
}
