//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Onur Yörük on 09.12.21.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
