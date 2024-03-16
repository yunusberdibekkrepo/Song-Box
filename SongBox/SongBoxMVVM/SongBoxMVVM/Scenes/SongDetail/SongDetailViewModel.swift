//
//  SongDetailViewModel.swift
//  SongBoxMVVM
//
//  Created by Yunus Emre Berdibek on 16.03.2024.
//

import Foundation
import SongBoxAPI

final class SongDetailViewModel: SongDetailViewModelProtocol {
    var delegate: (any SongDetailViewModelDelegate)?
    var song: Song

    init(song: Song) {
        self.song = song
    }

    func load() {
        delegate?.showDetail(.init(song: song))
    }
}
