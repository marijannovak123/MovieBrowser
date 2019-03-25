//
//  AppDelegate.swift
//  MovieBrowser
//
//  Created by UHP Mac on 21/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private(set) var singletonContainer: Container!
    private(set) var viewModelContainer: Container!
    private(set) var viewControllerContainer: Container!
    
    static var instance: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        singletonContainer = SingletonContainer.build()
        viewModelContainer = ViewModelContainer.build(singletonContainer: singletonContainer)
        viewControllerContainer = ViewControllerContainer.build(viewModelContainer: viewModelContainer)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = getRootVC()
        window?.makeKeyAndVisible()
            
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    private func getRootVC() -> UIViewController {
        let defaults = singletonContainer.resolve(UserDefaultsHelper.self)!
        if defaults.isLoggedIn {
            return viewControllerContainer.resolve(SwipeVC.self)!
        } else {
            return viewControllerContainer.resolve(LoginVC.self)!
        }
    }
}

