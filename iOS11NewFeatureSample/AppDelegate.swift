//
//  AppDelegate.swift
//  iOS11NewFeatureSample
//
//  Created by pantosoft on 2017/9/26.
//  Copyright © 2017年 jianghongbing. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let rootViewController : TabBarViewController = {
        let tabBarController = TabBarViewController()
        let firstViewController = FirstViewController()
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        let firstNavigationController = NavigationController(rootViewController: firstViewController)
        let secondViewController = SecondViewController()
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        let secondNavigationController = NavigationController(rootViewController: secondViewController)
        tabBarController.setViewControllers([firstNavigationController, secondNavigationController], animated: true)
        return tabBarController
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        UINavigationBar.appearance().barTintColor = .orange
        
        return true
    }
}

