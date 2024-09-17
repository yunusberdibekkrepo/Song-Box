//
//  ViewController.swift
//  SongBoxVIPER
//
//  Created by Yunus Emre Berdibek on 15.03.2024.
//

import UIKit

final class SongListViewController: UIViewController, SongListViewProtocol {
    @IBOutlet var tableView: UITableView!

    var presenter: SongListPresenterProtocol!
    private var songs: [SongPresentation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .red

        presenter.load()
    }

    func handleOutput(_ output: SongListPresenterOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title
        case .setLoading(let bool):
            break
        case .showSongList(let array):
            self.songs = array
            tableView.reloadData()
        }
    }
}

extension SongListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongListCell", for: indexPath)
        let song = self.songs[indexPath.row]
        cell.textLabel?.text = "title"
        cell.detailTextLabel?.text = "label"
        return cell
    }
}

extension SongListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectSong(at: indexPath.row)
    }
}
