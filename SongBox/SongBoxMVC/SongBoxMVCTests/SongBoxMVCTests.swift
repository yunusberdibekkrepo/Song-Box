//
//  SongBoxMVCTests.swift
//  SongBoxMVCTests
//
//  Created by Yunus Emre Berdibek on 15.03.2024.
//

@testable import SongBoxAPI
@testable import SongBoxMVC
@testable import SongBoxUtility
import XCTest

final class SongBoxMVCTests: XCTestCase {
    private var service: MockService!
    private var view: MockTopSongListView!
    private var controller: SongListViewController!

    override func setUpWithError() throws { // Her test case içinde bunları yeni baştan oluşturuyor.
        service = MockService()
        view = MockTopSongListView()
        controller = SongListViewController()

        controller.customView = view
        controller.service = service
    }

    override func tearDownWithError() throws {}

    func testSongList() throws {
        // Given
        let song1 = try ResourceLoader.loadSong(resource: .song1)
        service.songs = [song1]

        // When
        controller.loadViewIfNeeded() // View yüklenmemiş ise load edilecek.

        // Then
        XCTAssertEqual(view.isLoadingValues, [true, false])
        XCTAssertEqual(view.songList?.count, 1)
        XCTAssertEqual(try view.songList?.element(at: 0).title, song1.name)
    }
}

private final class MockTopSongListView: SongListViewProtocol {
    var delegate: SongListViewDelegate?
    var songList: [SongPresentation]?
    var isLoadingValues: [Bool] = []

    func update(_ songList: [SongPresentation]) {
        self.songList = songList
    }

    func setLoading(_ isLoading: Bool) {
        isLoadingValues.append(isLoading)
    }
}

private final class MockService: SongsAPIProtocol {
    var songs: [Song] = []

    func fetchSongsResponse(completion: @escaping (Result<SongsResponse, Error>) -> Void) {
        completion(.success(SongsResponse(results: songs)))
    }
}
