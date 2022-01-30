//
//  EssentialFeediOSTests.swift
//  EssentialFeediOSTests
//
//  Created by Onur Yörük on 30.01.22.
//

import XCTest
@testable import EssentialFeediOS

final class FeedViewController {

    init(loader: FeedViewControllerTests.LoaderSpy) {

    }

}

class FeedViewControllerTests: XCTestCase {

    func test_init_doesNotLoadFeed() {
        let loader = LoaderSpy()
        let _ = FeedViewController(loader: loader)

        XCTAssertEqual(loader.loadCallCount, 0)
    }

    // MARK: - Helpers

    class LoaderSpy {
        private(set) var loadCallCount: Int = 0
    }

}

