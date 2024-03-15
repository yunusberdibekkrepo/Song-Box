//
//  SongDetailViewController.swift
//  SongBoxMVC
//
//  Created by Yunus Emre Berdibek on 16.03.2024.
//

import SongBoxAPI
import UIKit

final class SongDetailViewController: UIViewController {
    @IBOutlet var songDetailView: SongDetailView!
    var song: Song!

    override func viewDidLoad() {
        super.viewDidLoad()
        songDetailView.updateSongDetail(.init(song: song))
    }
}
