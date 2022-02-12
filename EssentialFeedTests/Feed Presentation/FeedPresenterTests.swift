//
//  FeedPresenterTests.swift
//  EssentialFeedTests
//
//  Created by Onur Yörük on 12.02.22.
//

import XCTest

final class FeedPresenter {
    init(view: Any) {

    }
}

class FeedPresenterTests: XCTestCase {

    func test_init_doesNotSendMessagesToView() {
        let view = ViewSpay()

        _ = FeedPresenter(view: view)

        XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
    }

    // MARK: - Helper

    private class ViewSpay {
        let messages = [Any]()
    }

}
