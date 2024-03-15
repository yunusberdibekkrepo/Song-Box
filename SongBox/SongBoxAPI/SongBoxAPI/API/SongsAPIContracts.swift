//
//  SongsAPIContracts.swift
//  SongBoxAPI
//
//  Created by Yunus Emre Berdibek on 15.03.2024.
//

import Foundation

public protocol SongsAPIProtocol {
    func fetchSongsResponse(completion: @escaping (Result<SongsResponse, Error>) -> Void)
}
