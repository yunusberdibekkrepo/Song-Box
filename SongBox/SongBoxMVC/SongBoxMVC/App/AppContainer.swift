//
//  AppContainer.swift
//  SongBoxMVC
//
//  Created by Yunus Emre Berdibek on 15.03.2024.
//

import Foundation
import SongBoxAPI

let app = AppContainer()

final class AppContainer {
    init() {}

    let router = AppRouter()
    let service = SongsAPI()
}
