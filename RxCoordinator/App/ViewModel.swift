//
//  ViewModel.swift
//  RxCoordinator
//
//  Created by Nino Zhang on 2022/11/24.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ViewModel {
    struct Dependency {
        let color: UIColor
        let isNav: Bool
    }
    private var nextSceneIndex: Int?
    private var nextType: TransitionType?
    private var nextColor: BGColor?

    private let bgColorBR: BehaviorRelay<UIColor>

    init(dep: Dependency) {
        self.bgColorBR = BehaviorRelay(value: dep.color)
    }

    lazy var bgColor: Driver<UIColor> = bgColorBR.asDriver()

    func selectNextScene(_ index: Int) {
        guard index > -1 else {
            nextSceneIndex = nil
            return
        }
        nextSceneIndex = index
    }

    func selectNextType(_ index: Int) {
        guard index > -1 else {
            nextType = nil
            return
        }
        nextType = TransitionType.allCases[index]
    }

    func selectNextColor(_ index: Int) {
        guard index > -1 else {
            nextColor = nil
            return
        }
        nextColor = BGColor.allCases[index]
    }

    func tapContinue() {
        guard let sceneIndex = nextSceneIndex,
              let type = nextType,
              let color = nextColor else { return }
        let nextDep = Dependency(color: color.color, isNav: type != .push)
        let scene: Scene = {
            switch sceneIndex {
            case 0: return .home(nextDep)
            case 1: return .feed(nextDep)
            default: return .profile(nextDep)
            }
        }()

        // We can call the Coordinator in ViewModel.
        Coordinator.shared.transition(to: scene, type: type)
    }
}


