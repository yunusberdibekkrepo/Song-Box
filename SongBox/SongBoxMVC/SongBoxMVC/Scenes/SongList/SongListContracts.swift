//
//  SongListContracts.swift
//  SongBoxMVC
//
//  Created by Yunus Emre Berdibek on 15.03.2024.
//

import Foundation

@objc protocol SongListViewProtocol: AnyObject {
    var delegate: SongListViewDelegate? { get set }

    func update(_ songList: [SongPresentation])
    func setLoading(_ isLoading: Bool)
}

@objc protocol SongListViewDelegate: AnyObject {
    func didSelectSong(at index: Int)
}
