//
//  SongBoxMVVMTests.swift
//  SongBoxMVVMTests
//
//  Created by Yunus Emre Berdibek on 16.03.2024.
//

@testable import SongBoxAPI
@testable import SongBoxMVVM
@testable import SongBoxUtility
import XCTest

final class SongBoxMVVMTests: XCTestCase {
    private var view: MockView!
    private var viewModel: SongListViewModel!
    private var service: MockService!

    override func setUpWithError() throws { // Her test case içinde kendi kopyasını oluşturuyor.
        view = MockView()
        service = MockService()
        viewModel = SongListViewModel(service: service)
        viewModel.delegate = view
    }

    override func tearDownWithError() throws {}

    func testExample() throws {
        // Given:
        let song1 = try ResourceLoader.loadSong(resource: .song1)
        let song3 = try ResourceLoader.loadSong(resource: .song3)
        service.songs = [song1, song3]

        // When:
        viewModel.load()

        // Then:
        XCTAssertEqual(view.outputs.count, 4)

        switch try view.outputs.element(at: 0) {
        case .updateTitle:
            break
        default:
            XCTFail("First output should be `updateTitle`")
        }

        XCTAssertEqual(try view.outputs.element(at: 1), .setLoading(true))
        XCTAssertEqual(try view.outputs.element(at: 2), .setLoading(false))

        switch try view.outputs.element(at: 3) {
        case .showSongList(let presentations):
            XCTAssertEqual(presentations.count, service.songs.count)
        default:
            XCTFail("This output should be `showSongList`")
        }
    }

    func testNavigation() throws {
        // Given:
        let song1 = try ResourceLoader.loadSong(resource: .song1)
        let song3 = try ResourceLoader.loadSong(resource: .song3)
        service.songs = [song1, song3]
        viewModel.load()
        view.reset()

        // When:
        viewModel.didSelectSong(at: 0)

        // Then:
        XCTAssertEqual(view.detailRouteCall, true)
    }
}

private final class MockView: SongListViewModelDelegate {
    var outputs: [SongListViewModelOutput] = []
    var detailRouteCall: Bool = false

    func navigate(to route: SongBoxMVVM.SongListViewRoute) {
        switch route {
        case .detail:
            detailRouteCall = true
        }
    }
    
    func reset() {
        outputs.removeAll()
        detailRouteCall = false
    }

    func handleViewModelOutput(_ output: SongListViewModelOutput) {
        outputs.append(output)
    }
}

private final class MockService: SongsAPIProtocol {
    var songs: [Song] = []

    func fetchSongsResponse(completion: @escaping (Result<SongsResponse, Error>) -> Void) {
        completion(.success(SongsResponse(results: songs)))
    }
}
