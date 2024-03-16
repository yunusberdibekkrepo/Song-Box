//
//  AppRouter.swift
//  SongBoxMVVM
//
//  Created by Yunus Emre Berdibek on 16.03.2024.
//

import UIKit

final class AppRouter {
    let window: UIWindow

    init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
    }

    func start() {
        let viewController = SongListBuilder.start()
        let navigationController = UINavigationController(rootViewController: viewController)
        window.backgroundColor = UIColor.systemBackground
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
