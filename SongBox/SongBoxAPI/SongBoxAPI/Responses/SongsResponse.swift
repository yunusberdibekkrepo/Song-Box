//
//  SongsResponse.swift
//  SongBoxAPI
//
//  Created by Yunus Emre Berdibek on 15.03.2024.
//

import Foundation

public struct SongsResponse: Decodable {
    public let results: [Song]

    private enum RootCodingKeys: String, CodingKey {
        case feed
    }

    private enum FeedCodingKeys: String, CodingKey {
        case results
    }

    init(results: [Song]) {
        self.results = results
    }

    public init(from decoder: any Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let feedContainer = try rootContainer.nestedContainer(keyedBy: FeedCodingKeys.self, forKey: .feed)
        self.results = try feedContainer.decode([Song].self, forKey: .results)
    }
}
