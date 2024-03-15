//
//  SongPresentation.swift
//  SongBoxMVC
//
//  Created by Yunus Emre Berdibek on 15.03.2024.
//

import Foundation
import SongBoxAPI

final class SongPresentation: NSObject {
    let title: String
    let detail: String

    init(title: String, detail: String) {
        self.title = title
        self.detail = detail

        super.init()
    }
}

extension SongPresentation {
    convenience init(song: Song) {
        self.init(title: song.name, detail: song.artistName)
    }
}
