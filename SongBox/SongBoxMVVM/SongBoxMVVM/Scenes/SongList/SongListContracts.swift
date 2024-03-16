//
//  SongListContracts.swift
//  SongBoxMVVM
//
//  Created by Yunus Emre Berdibek on 16.03.2024.
//

import Foundation

/// viewModel.load() Bu fonksiyonu viewModel kendisi extend edip view kontrol edicek.
protocol SongListViewModelProtocol {
    var delegate: SongListViewModelDelegate? { get set }
    func load()
    func didSelectSong(at index: Int)
}

enum SongListViewModelOutput: Equatable { // ViewModel outputs
    case updateTitle(String)
    case setLoading(Bool)
    case showSongList([SongPresentation])
}

enum SongListViewRoute {
    case detail(SongDetailViewModelProtocol)
}

protocol SongListViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: SongListViewModelOutput)
    func navigate(to route: SongListViewRoute)
}
