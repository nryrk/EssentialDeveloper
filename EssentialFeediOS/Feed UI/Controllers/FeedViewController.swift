//
//  FeedViewController.swift
//  EssentialFeediOS
//
//  Created by Onur Yörük on 30.01.22.
//

import UIKit

final public class FeedViewController: UITableViewController, UITableViewDataSourcePrefetching {

    private var refreshController: FeedRefreshViewController?
    var tableModel = [FeedImageCellController]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    convenience init(refreshController: FeedRefreshViewController) {
        self.init()
        self.refreshController = refreshController
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl = refreshController?.view

        tableView.prefetchDataSource = self
        refreshController?.refresh()
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellController(forRowAt: indexPath ).view()
    }

    public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cancelCellControllerLoad(forRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
         indexPaths.forEach { cellController(forRowAt: $0).preload() }
     }

    private func cellController(forRowAt indexPath: IndexPath) -> FeedImageCellController {
        return tableModel[indexPath.row]
    }

    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach(cancelCellControllerLoad)
    }

    private func cancelCellControllerLoad(forRowAt indexPath: IndexPath) {
        cellController(forRowAt: indexPath).cancelLoad()
    }
}
