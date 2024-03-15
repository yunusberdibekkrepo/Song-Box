//
//  SongDetailBuilder.swift
//  SongBoxMVC
//
//  Created by Yunus Emre Berdibek on 16.03.2024.
//

import SongBoxAPI
import UIKit

enum SongDetailBuilder {
    static func make(with song: Song) -> SongDetailViewController {
        let storyboard = UIStoryboard(name: "SongDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SongDetailViewController") as! SongDetailViewController
        viewController.song = song
        return viewController
    }
}
