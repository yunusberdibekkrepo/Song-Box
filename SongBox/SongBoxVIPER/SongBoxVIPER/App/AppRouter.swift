//
//  AppRouter.swift
//  SongBoxVIPER
//
//  Created by Yunus Emre Berdibek on 17.09.2024.
//

import Foundation

import UIKit

final class AppRouter {
    var window: UIWindow

    init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
    }

    func didFinishLaunchingWithOptions() {
        self.window.backgroundColor = UIColor.systemBackground
        self.window.rootViewController = UINavigationController(rootViewController: SongListBuilder.make())
        self.window.makeKeyAndVisible()
    }
}
