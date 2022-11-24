//
//  AppDelegate.swift
//  RxCoordinator
//
//  Created by Nino Zhang on 2022/11/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let dependency = ViewModel.Dependency(color: .white, isNav: true)
        Coordinator.shared.transition(to: .home(dependency), type: .root)

        self.window = Coordinator.shared.window
        self.window?.makeKeyAndVisible()
    
        return true
    }
}

