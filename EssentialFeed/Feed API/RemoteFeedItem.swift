//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Onur Yörük on 12.01.22.
//

import Foundation

internal struct RemoteFeedItem : Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal  let image: URL
}
