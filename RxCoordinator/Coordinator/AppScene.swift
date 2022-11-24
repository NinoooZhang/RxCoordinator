//
//  AppScene.swift
//  RxCoordinator
//
//  Created by Nino Zhang on 2022/11/24.
//

import Foundation

enum Scene {
    case home(ViewModel.Dependency)
    case feed(ViewModel.Dependency)
    case profile(ViewModel.Dependency)
}
