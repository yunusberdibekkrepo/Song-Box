//
//  SongDetailViewController.swift
//  SongBoxMVVM
//
//  Created by Yunus Emre Berdibek on 16.03.2024.
//

import SongBoxAPI
import UIKit

final class SongDetailViewController: UIViewController {
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!

    var viewModel: SongDetailViewModelProtocol! {
        didSet {
            self.viewModel.delegate = self
        }
    }

    var song: Song!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.load()
    }
}

extension SongDetailViewController: SongDetailViewModelDelegate {
    func showDetail(_ presentation: SongDetailPresentation) {
        self.titleLabel.text = presentation.title
        self.artistNameLabel.text = presentation.artistName
        self.genreLabel.text = presentation.genre
    }
}
