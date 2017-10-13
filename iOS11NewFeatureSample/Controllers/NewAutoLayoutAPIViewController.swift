//
//  NewAutoLayoutAPIViewController.swift
//  iOS11NewFeatureSample
//
//  Created by pantosoft on 2017/10/12.
//  Copyright © 2017年 jianghongbing. All rights reserved.
//

import UIKit

class NewAutoLayoutAPIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "new autolayout api"
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20);
        
    }
}
