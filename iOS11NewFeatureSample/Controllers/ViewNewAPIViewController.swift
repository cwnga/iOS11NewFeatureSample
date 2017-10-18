//
//  ViewNewAPIViewController.swift
//  iOS11NewFeatureSample
//
//  Created by pantosoft on 2017/10/16.
//  Copyright © 2017年 jianghongbing. All rights reserved.
//

import UIKit

class ViewNewAPIViewController: UIViewController {
    private lazy var layoutMarginsView: LayoutMarginsView = {
        let layoutMarginsView = LayoutMarginsView()
        layoutMarginsView.translatesAutoresizingMaskIntoConstraints = false
        layoutMarginsView.backgroundColor = .orange
        layoutMarginsView.layer.borderColor = UIColor.blue.cgColor
        layoutMarginsView.layer.borderWidth = 3.0
        add(title: "tap to change layout margins", action: #selector(changeLayoutMargin(_:)), forView: layoutMarginsView)
        return layoutMarginsView
    }()
    
    private lazy var directionalLayoutMarginsView: DirectionalLayoutMarginsView = {
        let directionalLayoutMarginsView = DirectionalLayoutMarginsView()
        directionalLayoutMarginsView.translatesAutoresizingMaskIntoConstraints = false
        directionalLayoutMarginsView.backgroundColor = .gray
        directionalLayoutMarginsView.layer.borderColor = UIColor.green.cgColor
        directionalLayoutMarginsView.layer.borderWidth = 3.0
        //insetLayoutMargins是否从safeArea开始,默认为true,如果为false,则忽略
//        directionalLayoutMarginsView.insetsLayoutMarginsFromSafeArea = true
        add(title: "tap to change directional layout margins", action: #selector(changeDirectionalLayoutMargins(_:)), forView: directionalLayoutMarginsView)
        return directionalLayoutMarginsView
    }()
    
    private lazy var safeAreaView: UIView = {
        let safeAreaView = SafeAreaView()
        safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        safeAreaView.backgroundColor = .purple
        safeAreaView.layer.borderColor = UIColor.orange.cgColor
        safeAreaView.layer.borderWidth = 3.0
        add(title: "safe area layout", action: #selector(changeSafeAreaInsets(_:)), forView: safeAreaView)
        return safeAreaView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [layoutMarginsView, directionalLayoutMarginsView, safeAreaView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
        view.addSubview(stackView)
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        
        print(#function, #line, view.layoutMargins, view.directionalLayoutMargins)
        NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: stackView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .leftMargin, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: stackView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .rightMargin, multiplier: 1.0, constant: 0).isActive = true
        
        //1.layoutMargin:subView到view各个方向上的间距,一般的view,系统会给一个{8, 8, 8, 8}的默认值,如果view是控制器的view,在竖屏方向,会提供一个(0.0, 16.0, 0, 16.0)的默认值,横屏方向提供一个(0.0, 20.0, 0, 20.0)的默认值
        //2.preservesSuperviewLayoutMargins:是否尊敬superView的layoutMargins,默认为false,如果为false会影响到subView的布局
        //3.safe area:对非controller的rootView,建议不要使用safe area来进行布局,该属性用于controller的rootView
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "changeLayoutMargin", style: .plain, target: self, action: #selector(changeLayoutMargin(_:)))
    }
    
    @objc private func changeLayoutMargin(_ gestureRecognizer: UITapGestureRecognizer) {
        let edgeMargins = UIEdgeInsetsMake(8, 8, 8, 8)
        if UIEdgeInsetsEqualToEdgeInsets(layoutMarginsView.layoutMargins, edgeMargins) {
            layoutMarginsView.layoutMargins = UIEdgeInsetsMake(10, 20, 10, 20)
        }else {
            layoutMarginsView.layoutMargins = edgeMargins
        }
    }
    
    @objc private func changeDirectionalLayoutMargins(_ gestureRecognizer: UITapGestureRecognizer) {
        let directionalLayoutMargin = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
        if directionalLayoutMarginsView.directionalLayoutMargins.isEqualTo(another: directionalLayoutMargin) {
            directionalLayoutMarginsView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 50, leading: 40, bottom: 10, trailing: 20)
        }else {
            directionalLayoutMarginsView.directionalLayoutMargins = directionalLayoutMargin
        }
    }
    
    @objc private func changeSafeAreaInsets(_ gestureRecognizer: UITapGestureRecognizer) {
        print("safe area insets:\(safeAreaView.safeAreaInsets),frame:\(safeAreaView.safeAreaLayoutGuide.layoutFrame)")
    }
    
    
    private func add(title: String, action: Selector, forView: UIView) {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = title
        forView.addSubview(label)
        forView.bringSubview(toFront: label)
        label.centerXAnchor.constraint(equalTo: forView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: forView.centerYAnchor).isActive = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: action)
        forView.addGestureRecognizer(gestureRecognizer)
    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        print(#function, #line, view.layoutMargins, view.directionalLayoutMargins)
//    }
}

extension NSDirectionalEdgeInsets {
    internal func isEqualTo(another: NSDirectionalEdgeInsets) -> Bool {
        return top == another.top && leading == another.leading && trailing == another.trailing && bottom == another.bottom;
    }
}
