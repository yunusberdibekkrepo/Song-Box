//
//  SongListViewController.swift
//  SongBoxMVC
//
//  Created by Yunus Emre Berdibek on 15.03.2024.
//

import SongBoxAPI
import UIKit

/// Burada view controller presenter gibi davranıyor. Service ise model gibi. Bunun yanında controller view'i yönetiyor.
final class SongListViewController: UIViewController {
    @IBOutlet var customView: SongListViewProtocol! {
        didSet {
            customView.delegate = self
        }
    }

    var service: SongsAPIProtocol!
    private var songList: [Song] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Songs"

        customView.setLoading(true)
        service.fetchSongsResponse { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let value):
                self.songList = value.results
                let songPresentations = value.results.map { SongPresentation(song: $0) }
                self.customView.update(songPresentations)
            case .failure(let error):
                print(error.localizedDescription)
            }

            self.customView.setLoading(false)
        }
    }
}

extension SongListViewController: SongListViewDelegate {
    func didSelectSong(at index: Int) {
        let song = songList[index]
        let songDetailViewController = SongDetailBuilder.make(with: song)

        show(songDetailViewController, sender: nil)
    }
}
