//
//  SongDetailView.swift
//  SongBoxMVC
//
//  Created by Yunus Emre Berdibek on 16.03.2024.
//

import UIKit

final class SongDetailView: UIView {
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
}

extension SongDetailView: SongDetailViewProtocol {
    func updateSongDetail(_ songDetail: SongDetailPresentation) {
        titleLabel.text = songDetail.title
        artistNameLabel.text = songDetail.artistName
        genreLabel.text = songDetail.genre
    }
}
