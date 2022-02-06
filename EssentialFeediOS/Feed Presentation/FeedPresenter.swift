//
//  FeedViewPresenter.swift
//  EssentialFeediOS
//
//  Created by Onur Yörük on 04.02.22.
//

import Foundation
import EssentialFeed

struct FeedLoadingViewModel {
    var isLoading: Bool
}

protocol FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel)
}

struct FeedViewModel {
    var feed: [FeedImage]
}

protocol FeedView {
    func display(_ viewModel: FeedViewModel)
}

final class FeedPresenter {
    private let feedView: FeedView
    private let loadingView: FeedLoadingView

    static var title: String {
        return NSLocalizedString("FEED_VIEW_TITLE",
                                 tableName: "Feed",
                                 bundle: Bundle(for: FeedPresenter.self),
                                 comment: "Title for the feed view")
    }

    init(feedView: FeedView, loadingView: FeedLoadingView) {
        self.feedView = feedView
        self.loadingView = loadingView
    }

    func didStartLoadingFeed() {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async { [weak self] in self?.didStartLoadingFeed() }
        }

        loadingView.display(FeedLoadingViewModel(isLoading: true))
    }

    func didFinishLoadingView(with feed: [FeedImage]) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async { [weak self] in self?.didFinishLoadingView(with: feed) }
        }

        feedView.display(FeedViewModel(feed: feed))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }

    func didFinishLoadingView(with error: Error) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async { [weak self] in self?.didFinishLoadingView(with: error) }
        }

        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
}
