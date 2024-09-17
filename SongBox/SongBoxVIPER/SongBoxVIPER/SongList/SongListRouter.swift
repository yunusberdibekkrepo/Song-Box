//
//  SongListRouter.swift
//  SongBoxVIPER
//
//  Created by Yunus Emre Berdibek on 17.09.2024.
//

import UIKit

final class SongListRouter: SongListRouterProtocol {
    /// Router view'i tutuyor.
    unowned let view: UIViewController

    init(view: UIViewController) {
        self.view = view
    }

    func navigate(to route: SongListRoute) {
        switch route {
        case .detail(let song):
            let detailView = UIViewController()
            view.show(detailView, sender: nil)
        }
    }
}
