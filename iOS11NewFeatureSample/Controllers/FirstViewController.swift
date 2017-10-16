//
//  FirstViewController.swift
//  iPhoneXDemo
//
//  Created by pantosoft on 2017/9/25.
//  Copyright © 2017年 jianghongbing. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    static let cellIdentifier = "SaveAreaCell"
    let dataSources = ["safe area", "bars height","Bolder navigation", "contentInsetAdjustmentBehavior", "new auto layout API property", "new API in UIViewController", "new API in UIView", "Drag and Drop"]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "iOS11"
        
        addTableView()
    }
    
    private func addTableView() {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: FirstViewController.cellIdentifier)
        view.addSubview(tableView)
        
        NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
    }
}

extension FirstViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FirstViewController.cellIdentifier, for: indexPath)
        cell.textLabel?.text = dataSources[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var willPushedViewController: UIViewController?
        if indexPath.row == 0 {
            willPushedViewController = SafeAreaViewController()
        }else if indexPath.row == 1 {
            willPushedViewController = BarsHeightViewController()
        }else if indexPath.row == 2 {
            willPushedViewController = BolderNavigationViewController()
        }else if indexPath.row == 3 {
            willPushedViewController = ContentInsetViewController()
        }else if indexPath.row == 4 {
            willPushedViewController = NewAutoLayoutAPIViewController()
        }else if indexPath.row == 5 {
            willPushedViewController = NewFeatureInViewController()
            willPushedViewController?.hidesBottomBarWhenPushed = true 
        }else if indexPath.row == 6 {
            willPushedViewController = ViewNewAPIViewController()
            willPushedViewController?.hidesBottomBarWhenPushed = true 
        }
        
        if let viewController = willPushedViewController {
//            viewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
