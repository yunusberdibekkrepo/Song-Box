//
//  SongBoxVIPERTests.swift
//  SongBoxVIPERTests
//
//  Created by Yunus Emre Berdibek on 17.09.2024.
//

@testable import SongBoxAPI
@testable import SongBoxUtility
@testable import SongBoxVIPER

import XCTest

final class SongBoxVIPERTests: XCTestCase {
    private var presenter: SongListPresenter!
    private var interactor: SongListInteractor!
    private var service: MockService!
    private var view: MockSongListView!
    private var router: MockSongListRouter!

    override func setUpWithError() throws {
        service = MockService()
        interactor = SongListInteractor(service: service)
        view = MockSongListView()
        router = MockSongListRouter()

        presenter = .init(view: view,
                          interactor: interactor,
                          router: router)

        view.presenter = presenter
    }

    func testLoad() throws {
        // Given: Sistemin o an bulunan hali
        let song1 = try ResourceLoader.loadSong(resource: .song1)
        let song2 = try ResourceLoader.loadSong(resource: .song2)
        service.songs = [song1, song2]

        // When: Test ettiğimiz aksiyon.
        view.viewDidLoad()

        // Then: Test edilen aksiyondan sonra meydana gelen değişimler
        XCTAssertEqual(view.outputs.count, 4)

        let output = try view.outputs.element(at: 0)

        switch output {
        case .updateTitle(let string):
            break
        default:
            XCTFail()
        }

        XCTAssertEqual(try view.outputs.element(at: 1), .setLoading(true))
        XCTAssertEqual(try view.outputs.element(at: 2), .setLoading(false))

        let expectedSongs = service.songs.map { SongPresentation(song: $0) }
        XCTAssertEqual(try view.outputs.element(at: 3), .showSongList(expectedSongs))
    }

    func testSelectSong() throws {
        // Given:
        let song1 = try ResourceLoader.loadSong(resource: .song1)
        let song2 = try ResourceLoader.loadSong(resource: .song2)
        service.songs = [song1, song2]
        view.viewDidLoad()

        // When: Test ettiğimiz aksiyon.
        view.selectSong(at: 0)

        // Then: Test edilen aksiyondan sonra meydana gelen değişimler
        XCTAssertEqual(try router.routes.element(at: 0), .detail(try service.songs.element(at: 0)))
    }
}

private final class MockSongListView: SongListViewProtocol {
    var presenter: SongListPresenter!
    var outputs: [SongListPresenterOutput] = []

    func viewDidLoad() {
        presenter.load()
    }

    func handleOutput(_ output: SongBoxVIPER.SongListPresenterOutput) {
        outputs.append(output)
    }

    func selectSong(at index: Int) {
        presenter.selectSong(at: index)
    }
}

private final class MockService: SongsAPIProtocol {
    var songs: [Song] = []

    func fetchSongsResponse(completion: @escaping (Result<SongsResponse, Error>) -> Void) {
        completion(.success(SongsResponse(results: songs)))
    }
}

private final class MockSongListRouter: SongListRouterProtocol {
    var routes: [SongListRoute] = []

    func navigate(to route: SongBoxVIPER.SongListRoute) {
        routes.append(route)
    }
}
