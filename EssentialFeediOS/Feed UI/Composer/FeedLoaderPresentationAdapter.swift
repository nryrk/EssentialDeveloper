//
//  FeedLoaderPresentationAdapter.swift
//  EssentialFeediOS
//
//  Created by Onur Yörük on 06.02.22.
//

import Foundation
import EssentialFeed

final class FeedLoaderPresentationAdapter: FeedRefreshViewControllerDelegate {
    private let feedLoader: FeedLoader
    var presenter: FeedPresenter?

    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }

    func didRequestFeedRefresh() {
        presenter?.didStartLoadingFeed()

        feedLoader.load { [weak self] result in
            switch result {
            case let .success(feed):
                self?.presenter?.didFinishLoadingView(with: feed)
            case let .failure(error):
                self?.presenter?.didFinishLoadingView(with: error)
            }
        }
    }
}
