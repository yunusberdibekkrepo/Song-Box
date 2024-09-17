//
//  SongListBuilder.swift
//  SongBoxVIPER
//
//  Created by Yunus Emre Berdibek on 17.09.2024.
//

import UIKit

final class SongListBuilder {
    static func make() -> SongListViewController {
        let storyboard = UIStoryboard(name: "SongList", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SongListViewController") as! SongListViewController
        let router = SongListRouter(view: view)
        let interactor = SongListInteractor(service: app.service)
        let presenter = SongListPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
