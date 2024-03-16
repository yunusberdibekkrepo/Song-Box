//
//  AppContainer.swift
//  SongBoxMVVM
//
//  Created by Yunus Emre Berdibek on 16.03.2024.
//

import Foundation
import SongBoxAPI

let app = AppContainer()

final class AppContainer {
    init() {}

    let router = AppRouter()
    let service = SongsAPI()
}
