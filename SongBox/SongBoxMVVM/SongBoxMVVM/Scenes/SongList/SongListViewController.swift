//
//  SongListViewController.swift
//  SongBoxMVVM
//
//  Created by Yunus Emre Berdibek on 15.03.2024.
//

import SongBoxAPI
import UIKit

final class SongListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    var viewModel: SongListViewModelProtocol! {
        didSet {
            self.viewModel.delegate = self
        }
    }

    private var songList: [SongPresentation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.load()
    }

    private func handleIndicatorStatus(_ showLoading: Bool) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self else { return }

            if showLoading {
                self.tableView.isHidden = true
                self.tableView.alpha = 0
                self.activityIndicator.startAnimating()

            } else {
                self.tableView.isHidden = false
                self.tableView.alpha = 1
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

extension SongListViewController: SongListViewModelDelegate {
    func handleViewModelOutput(_ output: SongListViewModelOutput) {
        switch output {
        case .updateTitle(let string):
            title = string
        case .setLoading(let bool):
            self.handleIndicatorStatus(bool)
        case .showSongList(let array):
            self.songList = array
            self.tableView.reloadData()
        }
    }

    func navigate(to route: SongListViewRoute) {
        switch route {
        case .detail(let viewModel):
            let viewController = SongDetailBuilder.make(with: viewModel)
            show(viewController, sender: true)
        }
    }
}

extension SongListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.songList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongListCell", for: indexPath)
        let song = self.songList[indexPath.row]
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.detail
        return cell
    }
}

extension SongListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectSong(at: indexPath.row)
    }
}
