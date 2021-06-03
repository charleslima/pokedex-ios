//
//  AppDelegate.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 03/06/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let dependencyInjectionManager = DependencyInjectionManager()
    private var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.appCoordinator = AppCoordinator(
            window: self.window,
            container: dependencyInjectionManager.container
        )
        self.appCoordinator?.start()
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

