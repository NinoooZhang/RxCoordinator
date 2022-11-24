//
//  AppScene+ViewController.swift
//  RxCoordinator
//
//  Created by Nino Zhang on 2022/11/24.
//

import UIKit

extension Scene {
    func viewController() -> UIViewController {
        switch self {
        case let .home(dep):
            let home = HomeViewController(viewModel: ViewModel(dep: dep))
            if !dep.isNav {
                return home
            } else {
                return UINavigationController(rootViewController: home)
            }

        case let .feed(dep):
            let feed = FeedViewController(viewModel: ViewModel(dep: dep))
            if !dep.isNav {
                return feed
            } else {
                return UINavigationController(rootViewController: feed)
            }

        case let .profile(dep):
            let profile = ProfileViewController(viewModel: ViewModel(dep: dep))
            if !dep.isNav {
                return profile
            } else {
                return UINavigationController(rootViewController: profile)
            }
        }
    }
}

