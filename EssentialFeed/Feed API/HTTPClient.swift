//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Onur Yörük on 09.12.21.
//

import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>

    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate theads, if needed
    func get(from url: URL, completion: @escaping (Result) -> Void)
}
