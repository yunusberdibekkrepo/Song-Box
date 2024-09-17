//
//  SongListInteractor.swift
//  SongBoxVIPER
//
//  Created by Yunus Emre Berdibek on 17.09.2024.
//

import Foundation
import SongBoxAPI

final class SongListInteractor: SongListInteractorProtocol {
    weak var delegate: SongListInteractorDelegate?

    private let service: SongBoxAPI.SongsAPIProtocol
    private var songs: [Song] = []

    init(service: SongBoxAPI.SongsAPIProtocol) {
        self.service = service
    }

    func load() {
        delegate?.handleOutput(.setLoading(true))
        service.fetchSongsResponse { [weak self] result in
            guard let self else { return }
            self.delegate?.handleOutput(.setLoading(false))

            switch result {
            case .success(let value):
                self.songs = value.results
                self.delegate?.handleOutput(.showSongList(value.results))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func selectSong(at index: Int) {
        let song = songs[index]

        delegate?.handleOutput(.showSongDetail(song))
    }
}
