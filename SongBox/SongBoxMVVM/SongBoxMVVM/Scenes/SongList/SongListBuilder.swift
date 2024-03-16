//
//  SongListBuilder.swift
//  SongBoxMVVM
//
//  Created by Yunus Emre Berdibek on 16.03.2024.
//

import UIKit

/// Her tarafta import yapmak yerine bütün import ve inject işlemlerini burada yapıp sadece kullanaacak kişiye view'i döndürüyoruz.
enum SongListBuilder {
    static func start() -> SongListViewController {
        let storyboard = UIStoryboard(name: "SongList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SongListViewController") as! SongListViewController
        viewController.viewModel = SongListViewModel(service: app.service)
        return viewController
    }
}
