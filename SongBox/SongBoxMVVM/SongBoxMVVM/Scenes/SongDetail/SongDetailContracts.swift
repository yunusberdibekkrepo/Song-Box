//
//  SongDetailContracts.swift
//  SongBoxMVVM
//
//  Created by Yunus Emre Berdibek on 16.03.2024.
//

import Foundation

protocol SongDetailViewModelProtocol {
    var delegate: SongDetailViewModelDelegate? { get set }

    func load()
}

protocol SongDetailViewModelDelegate: NSObject {
    func showDetail(_ presentation: SongDetailPresentation)
}
