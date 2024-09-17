//
//  AppContainer.swift
//  SongBoxVIPER
//
//  Created by Yunus Emre Berdibek on 17.09.2024.
//

import Foundation
import SongBoxAPI

let app = AppContainer()

final class AppContainer {
    init() {}

    let router = AppRouter()
    let service = SongsAPI()
}
