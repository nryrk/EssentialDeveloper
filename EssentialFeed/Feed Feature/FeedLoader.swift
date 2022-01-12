//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Onur Yörük on 08.12.21.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedImage])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
