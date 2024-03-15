//
//  ResourceLoader.swift
//  SongBoxMVC
//
//  Created by Yunus Emre Berdibek on 15.03.2024.
//

import Foundation
import SongBoxAPI

class ResourceLoader {
    enum SongResource: String {
        case song1
        case song2
        case song3
    }

    static func loadSong(resource: SongResource) throws -> Song {
        let bundle = Bundle.test
        let url = bundle.url(forResource: resource.rawValue, withExtension: "json").unsafelyUnwrapped
        let data = try Data(contentsOf: url)
        let decoder = Decoders.plainDateDecoder
        let song = try decoder.decode(Song.self, from: data)
        return song
    }
}

private extension Bundle {
    class Dummy {}

    static let test = Bundle(for: Dummy.self)
}
