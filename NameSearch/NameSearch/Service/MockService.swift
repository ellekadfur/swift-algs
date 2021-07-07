//
//  MockService.swift
//  NameSearch
//
//  Created by Lamar Caaddfiir on 7/7/21.
//  Copyright © 2021 GoDaddy Inc. All rights reserved.
//

import Foundation


//TODO: use mock service in Unit test.
class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: (() -> Void)

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}

class URLSessionMock: URLSession {
    var data: Data?
    var error: Error?

    override func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        let data = self.data
        let error = self.error

        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
}
