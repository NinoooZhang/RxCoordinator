//
//  View.swift
//  RxCoordinator
//
//  Created by Nino Zhang on 2022/11/24.
//

import UIKit
import SnapKit

class View: UIView {
    lazy var title = UILabel().then {
        $0.font = .systemFont(ofSize: 25, weight: .bold)
        $0.textColor = .black
    }

    lazy var sceneLabel = UILabel().then {
        $0.text = "Next Scene"
        $0.font = .systemFont(ofSize: 15, weight: .medium)
        $0.textColor = .black
    }

    lazy var sceneControl = UISegmentedControl(items: ["Home", "Feed", "Profile"])

    lazy var typeLabel = UILabel().then {
        $0.text = "With Type"
        $0.font = .systemFont(ofSize: 15, weight: .medium)
        $0.textColor = .black
    }

    lazy var typeControl = UISegmentedControl(items: TransitionType.allCases.map { $0.name })

    lazy var colorLabel = UILabel().then {
        $0.text = "Use Color"
        $0.font = .systemFont(ofSize: 15, weight: .medium)
        $0.textColor = .black
    }

    lazy var colorControl = UISegmentedControl(items: BGColor.allCases.map { $0.name })

    lazy var button = UIButton().then {
        $0.setTitle("Execute", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        sceneControl.selectedSegmentIndex = Int.random(in: 0..<3)
        typeControl.selectedSegmentIndex = Int.random(in: 0..<3)
        colorControl.selectedSegmentIndex = Int.random(in: 0..<3)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(title)
        addSubview(sceneLabel)
        addSubview(sceneControl)
        addSubview(typeLabel)
        addSubview(typeControl)
        addSubview(colorLabel)
        addSubview(colorControl)
        addSubview(button)

        title.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide).offset(25)
        }

        sceneLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(sceneControl.snp.top).offset(-10)
        }
        sceneControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(typeLabel.snp.top).offset(-25)
        }

        typeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(typeControl.snp.top).offset(-10)
        }
        typeControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(colorLabel.snp.top).offset(-25)
            $0.centerY.equalToSuperview()
        }

        colorLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(colorControl.snp.top).offset(-10)
        }
        colorControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }

        button.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-25)
        }
    }
}
