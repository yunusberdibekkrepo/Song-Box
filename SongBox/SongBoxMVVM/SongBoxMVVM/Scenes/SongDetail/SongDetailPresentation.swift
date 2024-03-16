//
//  SongDetailPresentation.swift
//  SongBoxMVVM
//
//  Created by Yunus Emre Berdibek on 16.03.2024.
//

import Foundation
import SongBoxAPI

struct SongDetailPresentation {
    let title: String
    let artistName: String
    let genre: String
}

extension SongDetailPresentation {
    init(song: Song) {
        self.init(title: song.name,
                  artistName: song.artistName,
                  genre: song.genres.map { $0.name.rawValue }.joined(separator: ","))
    }
}
