//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Onur Yörük on 19.01.22.
//

import Foundation

func anyNSError() -> NSError { NSError(domain: "Any Error", code: 0) }

func anyURL() -> URL { URL(string: "http://any-url.com")! }
