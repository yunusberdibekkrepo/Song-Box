//
//  Song.swift
//  SongBoxAPI
//
//  Created by Yunus Emre Berdibek on 15.03.2024.
//

import Foundation

public struct Song: Codable {
    public let artistName, id, name, releaseDate: String
    public let kind: Kind
    public let artistID: String
    public let artistURL: String
    public let artworkUrl100: String
    public let genres: [Genre]
    public let url: String
    public let contentAdvisoryRating: String?

    enum CodingKeys: String, CodingKey {
        case artistName, id, name, releaseDate, kind
        case artistID = "artistId"
        case artistURL = "artistUrl"
        case artworkUrl100, genres, url, contentAdvisoryRating
    }
}

public struct Genre: Codable {
    public let genreID: String
    public let name: Name
    public let url: String

    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case name, url
    }
}

public enum Name: String, Codable {
    case alternative = "Alternative"
    case hipHopRap = "Hip-Hop/Rap"
    case music = "Music"
    case pop = "Pop"
    case rock = "Rock"
}

public enum Kind: String, Codable {
    case songs
}
