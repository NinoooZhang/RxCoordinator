//
//  Helpers.swift
//  RxCoordinator
//
//  Created by Nino Zhang on 2022/11/24.
//

import UIKit

extension TransitionType: CaseIterable {
    static var allCases: [TransitionType] = [.root, .push, .modal]
}

extension TransitionType {
    var name: String {
        switch self {
        case .root:  return "Root"
        case .push:  return "Push"
        case .modal: return "Modal"
        }
    }
}

enum BGColor: CaseIterable {
    case white, brown, cyan
}

extension BGColor {
    var name: String {
        switch self {
        case .white:  return "White"
        case .brown:   return "Brown"
        case .cyan: return "Cyan"
        }
    }
    var color: UIColor {
        switch self {
        case .white:  return .white
        case .brown:   return .systemBrown
        case .cyan: return .systemCyan
        }
    }
}
