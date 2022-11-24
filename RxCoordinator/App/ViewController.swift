//
//  ViewController.swift
//  RxCoordinator
//
//  Created by Nino Zhang on 2022/11/24.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let customView = View()
    private let viewModel: ViewModel

    override func loadView() {
        view = customView
    }

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.bgColor
            .drive(view.rx.backgroundColor)
            .disposed(by: rx.disposeBag)

        customView.sceneControl.rx
            .selectedSegmentIndex
            .subscribe(onNext: { [weak self] index in
                self?.viewModel.selectNextScene(index)
            })
            .disposed(by: rx.disposeBag)

        customView.typeControl.rx
            .selectedSegmentIndex
            .subscribe(onNext: { [weak self] index in
                self?.viewModel.selectNextType(index)
            })
            .disposed(by: rx.disposeBag)

        customView.colorControl.rx
            .selectedSegmentIndex
            .subscribe(onNext: { [weak self] index in
                self?.viewModel.selectNextColor(index)
            })
            .disposed(by: rx.disposeBag)

        customView.button.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.tapContinue()
            })
            .disposed(by: rx.disposeBag)
    }
}
