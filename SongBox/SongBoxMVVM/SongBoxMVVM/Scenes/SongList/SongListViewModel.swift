//
//  SongListViewModel.swift
//  SongBoxMVVM
//
//  Created by Yunus Emre Berdibek on 16.03.2024.
//

import Foundation
import SongBoxAPI

final class SongListViewModel {
    weak var delegate: (any SongListViewModelDelegate)?
    private let service: SongsAPIProtocol
    private var songs: [Song] = []

    init(service: SongsAPIProtocol) {
        self.service = service
    }

    private func notify(output: SongListViewModelOutput) {
        DispatchQueue.main.async {
            self.delegate?.handleViewModelOutput(output)
        }
    }
}

extension SongListViewModel: SongListViewModelProtocol {
    func load() {
        notify(output: .updateTitle("Songs"))
        notify(output: .setLoading(true))

        service.fetchSongsResponse(completion: { [weak self] result in
            guard let self else { return }
            self.notify(output: .setLoading(false))

            switch result {
            case .success(let response):
                let songs = response.results
                self.songs = songs
                let presentations = songs.map { SongPresentation(song: $0) }
                self.notify(output: .showSongList(presentations))
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }

    func didSelectSong(at index: Int) {
        let song = songs[index]
        let viewModel = SongDetailViewModel(song: song)

        delegate?.navigate(to: .detail(viewModel))
    }
}
