//
//  ViewControllers.swift
//  RxCoordinator
//
//  Created by Nino Zhang on 2022/11/24.
//

import UIKit

class HomeViewController: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.title.text = "Home"
    }
}

class FeedViewController: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.title.text = "Feed"
    }
}

class ProfileViewController: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.title.text = "Profile"
    }
}
