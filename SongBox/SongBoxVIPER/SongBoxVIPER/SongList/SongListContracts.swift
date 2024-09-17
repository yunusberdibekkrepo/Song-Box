//
//  SongListContracts.swift
//  SongBoxVIPER
//
//  Created by Yunus Emre Berdibek on 17.09.2024.
//

import Foundation
import struct SongBoxAPI.Song

// MARK: - Interactor

protocol SongListInteractorProtocol: AnyObject {
    var delegate: SongListInteractorDelegate? { get set }

    func load()
    func selectSong(at index: Int)
}

enum SongListInteractorOutput: Equatable {
    case setLoading(Bool)
    case showSongList([Song])
    case showSongDetail(Song)
}

protocol SongListInteractorDelegate: AnyObject {
    func handleOutput(_ output: SongListInteractorOutput)
}

// MARK: - Presenter

protocol SongListPresenterProtocol: AnyObject {
    func load()
    func selectSong(at index: Int)
}

enum SongListPresenterOutput: Equatable {
    case updateTitle(String)
    case setLoading(Bool)
    case showSongList([SongPresentation])
}

// MARK: - View

protocol SongListViewProtocol: AnyObject {
    func handleOutput(_ output: SongListPresenterOutput)
}

// MARK: - Router

enum SongListRoute: Equatable {
    case detail(Song)
}

protocol SongListRouterProtocol: AnyObject {
    func navigate(to route: SongListRoute)
}
