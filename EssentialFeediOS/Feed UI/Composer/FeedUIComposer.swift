//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by Onur Yörük on 02.02.22.
//

import Foundation
import EssentialFeed
import UIKit

public final class FeedUIComposer {

    private init() {}

    public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let presenter = FeedPresenter(feedLoader: feedLoader)
        //let feedViewModel = FeedViewModel(feedLoader: feedLoader)
        let refreshController = FeedRefreshViewController(presenter: presenter)
        presenter.loadingView = refreshController
        let feedController = FeedViewController(refreshController: refreshController)
        presenter.feedView = FeedViewAdapter(controller: feedController, imageLoader: imageLoader)
        //feedViewModel.onFeedLoad = adaptFeedToCellControllers(forwaringTo: feedController, loader: imageLoader)

        return feedController
    }

    private static func adaptFeedToCellControllers(forwaringTo controller: FeedViewController, loader: FeedImageDataLoader) -> ([FeedImage]) -> Void {
        return { [ weak controller] feed in
            controller?.tableModel = feed.map({ model in
                FeedImageCellController(viewModel: FeedImageViewModel(model: model, imageLoader: loader, imageTransformer: UIImage.init))
            })
        }
    }
}

private final class FeedViewAdapter: FeedView {
    private weak var controller: FeedViewController?
    private let imageLoader: FeedImageDataLoader

    init(controller: FeedViewController, imageLoader: FeedImageDataLoader) {
        self.controller = controller
        self.imageLoader = imageLoader
    }

    func display(feed: [FeedImage]) {
        controller?.tableModel = feed.map({ model in
            FeedImageCellController(viewModel: FeedImageViewModel(model: model, imageLoader: imageLoader, imageTransformer: UIImage.init))
        })
    }
}
