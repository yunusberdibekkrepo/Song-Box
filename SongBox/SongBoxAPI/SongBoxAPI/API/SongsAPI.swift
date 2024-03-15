//
//  SongsAPI.swift
//  SongBoxAPI
//
//  Created by Yunus Emre Berdibek on 15.03.2024.
//

import Foundation

public class SongsAPI: SongsAPIProtocol {
    public enum ClientError: Error {
        case networkError(internal: Error)
        case invalidStatusCodeEror(code: Int)
        case serializationError(internal: Error)
    }

    public init() {}

    public func fetchSongsResponse(completion: @escaping (Result<SongsResponse, Error>) -> Void) {
        let urlString = "https://rss.applemarketingtools.com/api/v2/tr/music/most-played/25/songs.json"
        
        let task = URLSession.shared.dataTask(with: .init(url: URL(string: urlString)!)) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(ClientError.networkError(internal: error ?? URLError(.badURL))))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            guard (200 ... 299).contains(response.statusCode) else {
                completion(.failure(ClientError.invalidStatusCodeEror(code: response.statusCode)))
                return
            }

            do {
                let decoder = Decoders.plainDateDecoder
                let songs = try decoder.decode(SongsResponse.self, from: data)
                completion(.success(songs))
            } catch {
                completion(.failure(ClientError.serializationError(internal: error)))
            }
        }

        task.resume()
    }
}
