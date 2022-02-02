//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Onur Yörük on 02.02.22.
//

import Foundation
import UIKit
import EssentialFeed

final class FeedRefreshViewController: NSObject {

    private(set) lazy var view: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }()

    private var feedLoader: FeedLoader

    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }

    var onRefresh: (([FeedImage]) -> Void)?

    @objc func refresh() {
        view.beginRefreshing()
        feedLoader.load { [weak self] result in

            if let feed = try? result.get() {
                self?.onRefresh?(feed)
            }

            self?.view.endRefreshing()
        }
    }
}
