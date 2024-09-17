//
//  SongListPresenter.swift
//  SongBoxVIPER
//
//  Created by Yunus Emre Berdibek on 17.09.2024.
//

import Foundation

final class SongListPresenter: SongListPresenterProtocol {
    private unowned let view: SongListViewProtocol
    private let interactor: SongListInteractorProtocol
    private let router: SongListRouterProtocol

    init(view: SongListViewProtocol, interactor: SongListInteractorProtocol, router: SongListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router

        self.interactor.delegate = self
    }

    func load() {
        view.handleOutput(.updateTitle("Songs"))
        interactor.load()
    }

    func selectSong(at index: Int) {
        interactor.selectSong(at: index)
    }
}

extension SongListPresenter: SongListInteractorDelegate {
    func handleOutput(_ output: SongListInteractorOutput) {
        switch output {
        case .setLoading(let bool):
            view.handleOutput(.setLoading(bool))
        case .showSongList(let array):
            let presentations = array.map { SongPresentation(song: $0) }
            view.handleOutput(.showSongList(presentations))
        case .showSongDetail(let song):
            router.navigate(to: .detail(song))
        }
    }
}
