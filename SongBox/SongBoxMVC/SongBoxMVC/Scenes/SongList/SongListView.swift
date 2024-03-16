//
//  SongListView.swift
//  SongBoxMVC
//
//  Created by Yunus Emre Berdibek on 15.03.2024.
//

import UIKit

final class SongListView: UIView {
    weak var delegate: SongListViewDelegate?
    private var songList: [SongPresentation] = []
    @IBOutlet var songListTableView: UITableView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
}

extension SongListView: SongListViewProtocol {
    func update(_ songList: [SongPresentation]) {
        self.songList = songList

        DispatchQueue.main.async {
            self.songListTableView.reloadData()
        }
    }

    func setLoading(_ isLoading: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            if isLoading {
                self.activityIndicatorView.startAnimating()
                UIView.animate(withDuration: 0.2) {
                    self.songListTableView.isHidden = true
                    self.songListTableView.alpha = 0
                }
            } else {
                self.activityIndicatorView.stopAnimating()
                UIView.animate(withDuration: 0.2) {
                    self.songListTableView.isHidden = false
                    self.songListTableView.alpha = 1
                }
            }
        }
    }
}

extension SongListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongListCell", for: indexPath)
        let song = songList[indexPath.row]
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.detail
        return cell
    }
}

extension SongListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectSong(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
