//
//  CodableFeedStore.swift
//  EssentialFeed
//
//  Created by Onur Yörük on 23.01.22.
//

import Foundation

public class CodableFeedStore: FeedStore {

    private struct Cache: Codable {
        let feed: [CodableFeedImage]
        let timestamp: Date

        var localFeed: [LocalFeedImage] {
            return feed.map({ $0.local })
        }
    }

    private let queue = DispatchQueue(label: "\(CodableFeedStore.self)Queue", qos: .userInitiated, attributes: .concurrent)
    private let storeURL: URL

    public init(storeURL: URL) {
        self.storeURL = storeURL
    }

    public func retrieve(completion: @escaping RetrievalCompletion) {
        let storeURL = self.storeURL
        queue.async {
            guard let data = try? Data(contentsOf: storeURL) else { return completion(.success(.none)) }

            completion(Result {
                let decoder = JSONDecoder()
                let cache = try decoder.decode(Cache.self, from: data)
                return .some(CachedFeed(feed: cache.localFeed, timestamp: cache.timestamp))
            })
        }
    }

    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        let storeURL = self.storeURL
        queue.async(flags: .barrier) {

            completion(Result {
                let encoder = JSONEncoder()
                let cache = Cache(feed: feed.map({ CodableFeedImage($0) }), timestamp: timestamp)
                let encoded = try encoder.encode(cache)
                try encoded.write(to: storeURL)
            })
        }
    }

    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        let storeURL = self.storeURL
        queue.async(flags: .barrier) {
            guard FileManager.default.fileExists(atPath: storeURL.path) else {
                return completion(.success(()))
            }

            completion(Result {
                try FileManager.default.removeItem(at: storeURL)
            })
        }
    }

    private struct CodableFeedImage: Codable {
        private let id: UUID
        private let description: String?
        private let location: String?
        private let url: URL

        init(_ image: LocalFeedImage) {
            self.id = image.id
            self.description = image.description
            self.location = image.location
            self.url = image.url
        }

        var local: LocalFeedImage {
            return LocalFeedImage(id: id, description: description, location: location, url: url)
        }
    }
}
