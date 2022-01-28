//
//  FeedStoreSpecs.swift
//  EssentialFeedTests
//
//  Created by Onur Yörük on 25.01.22.
//

import Foundation

protocol FeedStoreSpecs {
    func test_retrieve_deliversEmptyOnEmptyCach()
    func test_retrieve_hasNoSideEffectsOnEmptyCache()
    func test_retrieve_deliversFoundValuesOnNonEmptyCache()
    func test_retrieve_hasNoSideEffectsOnNonEmptyCache()
    func test_retrieve_deliversFailureOnRetrieval()
    func test_retrieve_hasNoSideEffectsOnFailure()

    func test_insert_overridesPreviouslyInsertedCacheValues()

    func test_storeSideEffects_runSerially()
}

protocol FailableInsertFeedStoreSpecs: FeedStoreSpecs {
    func test_insert_deliversErrorOnInsertionError()
}
