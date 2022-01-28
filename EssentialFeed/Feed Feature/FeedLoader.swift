//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Onur Yörük on 08.12.21.
//

import Foundation

public typealias LoadFeedResult = Result<[FeedImage], Error> 

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
