//
//  BolderNavigationViewController.swift
//  iOS11NewFeatureSample
//
//  Created by pantosoft on 2017/10/12.
//  Copyright © 2017年 jianghongbing. All rights reserved.
//

import UIKit

class BolderNavigationViewController: UIViewController {
    private lazy var safeAreaView: UILabel = {
        let safeAreaView = UILabel()
        safeAreaView.backgroundColor = .gray
        safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        safeAreaView.layer.borderColor = UIColor.green.cgColor
        safeAreaView.layer.borderWidth = 3.0
        safeAreaView.text = "Safa Area"
        safeAreaView.font = UIFont.systemFont(ofSize: 20)
        safeAreaView.textAlignment = .center
        view.addSubview(safeAreaView)
        return safeAreaView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: UITableViewController())
        
        
        searchController.searchBar.placeholder = "bolder navigation"
        return searchController
    }()
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        NSLayoutConstraint.deactivate(view.constraints)
//        let views = ["safeAreaLayoutGuide": view.safeAreaLayoutGuide, "safeAreaView": safeAreaView] as [String : Any]
//        let horizonalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[safeAreaLayoutGuide][safeAreaView][safeAreaLayoutGuide]|", options: [], metrics: nil, views: views)
//        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[safeAreaLayoutGuide][safeAreaView][safeAreaLayoutGuide]|", options: [], metrics: nil, views: views)
//        NSLayoutConstraint.activate(horizonalConstraints + verticalConstraints)
        let topConstraint = NSLayoutConstraint(item: safeAreaView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0);
        let leftConstraint =  NSLayoutConstraint(item: safeAreaView, attribute: .left, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leftMargin, multiplier: 1.0, constant: 0);
        let rightConstraint =  NSLayoutConstraint(item: safeAreaView, attribute: .right, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .rightMargin, multiplier: 1.0, constant: 0);
        
        let bottomConstaint =  NSLayoutConstraint(item: safeAreaView, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0);
        NSLayoutConstraint.activate([topConstraint, leftConstraint, rightConstraint, bottomConstaint])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //1.设置是否偏好大标题
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
   override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        navigationItem.title = "Bolder Navigation"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "enableOrDisableLargeTitle", style: .plain, target: self, action: #selector(enableOrDisableLargeTitle(_:)))
        
        if let frame = navigationController?.navigationBar.frame {
            print("navigation bar frame:\(frame)")
        }
        
        //2.设置和获取large title的属性
        if let largeTitleAttributes = navigationController?.navigationBar.largeTitleTextAttributes {
            print("large title attributes:\(largeTitleAttributes)")

        }
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.orange, .font: UIFont.systemFont(ofSize: 25)]
        
        //3.是否大标题模式,只有在prefersLargeTitles为true的情况下,该属性才有生效,如果为false,这只会显示小标题,当设置为never,不管prefersLargeTitles是true,都不会显示大标题
        navigationItem.largeTitleDisplayMode = .automatic
        
        //4.当滚动的时候,是否隐藏searchBar
        navigationItem.hidesSearchBarWhenScrolling = true
        //5.设置navigationItem的search controller 
        navigationItem.searchController = searchController
    }
    
    @objc private func enableOrDisableLargeTitle(_ barbuttonItem: UIBarButtonItem) {
        if let preferLargeTitles = navigationController?.navigationBar.prefersLargeTitles {
            navigationController?.navigationBar.prefersLargeTitles = !preferLargeTitles
        }
        if let frame = navigationController?.navigationBar.frame {
            print("navigation bar frame:\(frame)")
        }
    }
}
