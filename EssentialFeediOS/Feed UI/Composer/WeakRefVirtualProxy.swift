//
//  WeakRefVirtualProxy.swift
//  EssentialFeediOS
//
//  Created by Onur Yörük on 06.02.22.
//

import Foundation
import EssentialFeed

final class WeakRefVirtualProxy<T: AnyObject> {
    private weak var object: T?

    init(_ object: T) {
        self.object = object
    }
}

extension WeakRefVirtualProxy: FeedLoadingView where T: FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel) {
        object?.display(viewModel)
    }
}
