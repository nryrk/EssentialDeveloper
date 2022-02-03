//
//  FeedViewModel.swift
//  EssentialFeediOS
//
//  Created by Onur Yörük on 03.02.22.
//

import Foundation
import EssentialFeed

final class FeedViewModel {

    private var feedLoader: FeedLoader

    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }

    var onChange: ((FeedViewModel) -> Void)?
    var onFeedLoad: (([FeedImage]) -> Void)?

    private(set) var isLoading: Bool = false {
        didSet { onChange?(self)  }
    }

    func loadFeed() {
        isLoading = true
        feedLoader.load { [weak self] result in

            if let feed = try? result.get() {
                self?.onFeedLoad?(feed)
            }
            self?.isLoading = false
        }
    }
}
