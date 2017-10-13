//
//  ContentInsetViewController.swift
//  iOS11NewFeatureSample
//
//  Created by pantosoft on 2017/10/12.
//  Copyright © 2017年 jianghongbing. All rights reserved.
//

import UIKit

class ContentInsetViewController: UIViewController {
    static let cellIdentifier = "contentInsetCell"
    private var didSetupConstraints = false
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: ContentInsetViewController.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //1.是否允许自动适应safeArea区域,与之前的Controller的automaticallyAdjustsScrollViewInsets有些类似
        //1.1 .automatic:自动适应, .scrollableAxes:在可以滚动的方向上适应, .never:不需要自动适应, .always:永远自动适应
        tableView.contentInsetAdjustmentBehavior = .automatic
        
        //4.cell分割线的inset是遵从cell的inset还是系统默认的
        tableView.separatorInsetReference = .fromCellEdges
        view.addSubview(tableView)
        return tableView
    }()
    
//    override func updateViewConstraints() {
//        super.updateViewConstraints()
//        if !didSetupConstraints {
//            loadViewIfNeeded()
//            NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
//            NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
//            NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
//            NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
////            NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
////            NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
////            NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
////            NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
//            didSetupConstraints = true
//        }
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "printInfo", style: .plain, target: self, action: #selector(logTableViewInfo(_:)))
//        NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
//        NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
//        NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
//        NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    @objc private func logTableViewInfo(_ barButtonItem: UIBarButtonItem) {
        print("contentInset:\(tableView.contentInset),contentOffset:\(tableView.contentOffset) frame:\(tableView.frame)")
        
        //2.adjustedContentInset:为了适应safeArea区域,所调整的contentInset,可能会改变contentOffset
        print("adjustContentInset:\(tableView.adjustedContentInset)")
        //3.scrollView的layoutGuide
        print("contentLayoutGuide:\(tableView.contentLayoutGuide.layoutFrame), frameLayoutGuide:\(tableView.frameLayoutGuide.layoutFrame)")
    }
}

extension ContentInsetViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContentInsetViewController.cellIdentifier, for: indexPath)
        cell.textLabel?.text = "section:\(indexPath.section), row:\(indexPath.row)"
        cell.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10)
        return cell
    }
    //3.当adjustContentInset改变时,该方法会回调,如屏幕方向的旋转会改变navigationBar和tabBar的高度时,导致adjustContentInset改变
    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        print(#function, "adjustedContentInset:\(scrollView.adjustedContentInset)")
    }
}
