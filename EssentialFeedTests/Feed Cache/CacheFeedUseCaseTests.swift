//
//  CacheFeedUseCase.swift
//  EssentialFeedTests
//
//  Created by Onur Yörük on 05.01.22.
//

import XCTest

class LocalFeedLoader {
    init(store: FeedStore) {

    }
}

class FeedStore {
    var deleteCachedFeedCallCount = 0
}

class CacheFeedUseCaseTests: XCTestCase {

    func  test_init_doesNotDeleteCacheUponCreation() {
        // The FeedStore is a helper class representing the framework side to help us define the abstract interface the Use Case needs for
        // its collaborater, making sure not to leak framework details into the Use Case
        let store = FeedStore()
        _ = LocalFeedLoader(store: store)

        XCTAssertEqual(store.deleteCachedFeedCallCount, 0)
    }

}
