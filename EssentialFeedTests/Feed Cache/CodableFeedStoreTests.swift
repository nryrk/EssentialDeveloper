//
//  CodableFeedStoreTests.swift
//  EssentialFeedTests
//
//  Created by Onur Yörük on 22.01.22.
//

import XCTest
import EssentialFeed

class CodableFeedStore {
    func retrieve(completion: @escaping FeedStore.RetrievalCompletion) {
        completion(.empty)
    }
}

class CodableFeedStoreTests: XCTestCase {

    func test_retrieve_deliversEmptyOnEmptyCach() {
        let sut = CodableFeedStore()

        let exp = expectation(description: "Wait for cache retrieval")
        sut.retrieve(){ result in
            switch result {
            case .empty:
                break
            default:
                 XCTFail("Expceted empty result, got \(result) instead")
            }

            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)

    }

}

