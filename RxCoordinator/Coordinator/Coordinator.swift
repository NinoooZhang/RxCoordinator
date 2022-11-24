//
//  Coordinator.swift
//  RxCoordinator
//
//  Created by Nino Zhang on 2022/11/24.
//

import UIKit
import RxSwift
import RxCocoa

enum TransitionType {
    case root       // make view controller the root view controller
    case push       // push view controller to navigation stack
    case modal      // present view controller modally
}

protocol CoordinatorProtocol {
    @discardableResult
    func transition(to scene: Scene, type: TransitionType) -> Completable

    @discardableResult
    func pop(animated: Bool) -> Completable

    @discardableResult
    func dismiss(animated: Bool) -> Completable
}

// MARK: - Coordinator

class Coordinator: CoordinatorProtocol {
    private(set) var window: UIWindow
    private(set) var currentViewController: UIViewController!
    private let disposeBag = DisposeBag()

    static let shared = Coordinator()

    private init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
    }

    static func actualViewController(for viewController: UIViewController) -> UIViewController {
        if let navigationController = viewController as? UINavigationController {
            return navigationController.viewControllers.first!
        } else {
            return viewController
        }
    }

    @discardableResult
    func transition(to scene: Scene, type: TransitionType) -> Completable {
        let completeSubject = PublishSubject<Void>()
        let viewController = scene.viewController()

        switch type {
        case .root:
            if let nav = viewController as? UINavigationController {
                nav.rx.didShow
                    .subscribe(onNext: { [weak self] _ in
                        self?.currentViewController = Coordinator.actualViewController(for: nav)
                    })
                    .disposed(by: nav.rx.disposeBag)
            } else {
                currentViewController = Coordinator.actualViewController(for: viewController)
            }

            // Animate root transition
            if let previous = window.rootViewController {
                UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
                    previous.view.alpha = 0

                } completion: { complete in
                    guard complete else { return }
                    self.window.rootViewController = viewController
                    viewController.view.alpha = 0
                    let options: UIView.AnimationOptions = [.transitionCrossDissolve, .curveEaseIn]

                    UIView.transition(with: self.window, duration: 0.5, options: options, animations: {
                        viewController.view.alpha = 1

                    }, completion: { complete in
                        guard complete else { return }
                        completeSubject.onCompleted()
                    })
                }
            } else {
                window.rootViewController = viewController
                completeSubject.onCompleted()
            }

        case .push:
            guard let navigationController = currentViewController.navigationController else { fatalError() }
            navigationController.pushViewController(viewController, animated: true)
            completeSubject.onCompleted()

        case .modal:
            let presentingViewController = currentViewController!

            if let nav = viewController as? UINavigationController {
                nav.rx.didShow
                    .map { $0.viewController }
                    .withUnretained(self)
                    .subscribe(onNext: { obj, vc in
                        obj.currentViewController = Coordinator.actualViewController(for: vc)
                    })
                    .disposed(by: nav.rx.disposeBag)

            } else {
                currentViewController = Coordinator.actualViewController(for: viewController)
            }

            presentingViewController.present(viewController, animated: true)
            completeSubject.onCompleted()

            viewController.rx.viewDidDisappear
                .withUnretained(self)
                .subscribe(onNext: { [weak viewController] (obj, _) in
                    guard viewController?.isBeingDismissed == true else { return }
                    obj.currentViewController = presentingViewController
                })
                .disposed(by: viewController.rx.disposeBag)
        }
        return completeSubject.ignoreElements().asCompletable()
    }

    @discardableResult
    func pop(animated: Bool) -> Completable {

        guard let navigationController = currentViewController.navigationController else {
            fatalError("Not modal or navigation controller: can't navigate back from \(String(describing: currentViewController))")
        }
        navigationController.popViewController(animated: animated)
        return Observable<Void>.just(()).ignoreElements().asCompletable()
    }

    @discardableResult
    func dismiss(animated: Bool) -> Completable {
        guard let presenter = currentViewController.presentingViewController else {
            fatalError("Not modal or navigation controller: can't navigate back from \(String(describing: currentViewController))")
        }
        let completeSubject = PublishSubject<Void>()
        currentViewController.dismiss(animated: animated) { [weak self] in
            self?.currentViewController = Coordinator.actualViewController(for: presenter)
            completeSubject.onCompleted()
        }
        return completeSubject.ignoreElements().asCompletable()
    }
}

