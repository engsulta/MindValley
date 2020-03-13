//
//  MVNetworkTests.swift
//  MindValleyTests
//
//  Created by Ahmed Sultan on 3/13/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import XCTest
@testable import MindValley

class MVNetworkTests: XCTestCase {
    var mockNetworkManager: MVNetworkManager!
    var mockSession: MockSession!
    override func setUp() {
         mockSession = MockSession()
         mockNetworkManager = MVNetworkManager(session: mockSession)
    }

    override func tearDown() {
        mockSession = nil
        mockNetworkManager = nil
    }

    func testRequestSucceed() {
        let exp = expectation(description: #function)
        mockNetworkManager.request(path: .newEpisodes, model: TestCoding.self) { [weak self] (response, error) in
            if error == nil {
                XCTAssertNotNil(response as? ResultDecodable<TestCoding>)
                XCTAssertEqual(self?.mockSession.urlSessionDataTaskMock.isResumedCalled, true)
            } else {
                XCTFail("decoding not work successfully")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 2.0)
    }
    func testRequestFailed() {
           let exp = expectation(description: #function)
        mockNetworkManager.request(path: .newEpisodes, model: String.self) { [weak self] (response, error) in
               if error != nil {
                  XCTAssertEqual(error, MVError.faildToDecode)
               } else {
                   XCTFail("decoding not work successfully")
               }
               exp.fulfill()
           }
           wait(for: [exp], timeout: 2.0)
       }
}

class URLSessionDataTaskMock: URLSessionDataTaskProtocol {
    var isResumedCalled = false

    func resume() {
        isResumedCalled = true
    }
}
class MockSession: URLSessionProtocol {
    var urlSessionDataTaskMock =  URLSessionDataTaskMock()
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with url: URL, completionHandler: @escaping MockSession.DataTaskResult) -> URLSessionDataTaskProtocol {
        let endPoint = MVEndPoint(rawValue: url.absoluteString)
        let test = TestCoding(name: "test1")
        let testCodableData = try? JSONEncoder().encode(TestCodableModel(data: test))
        switch endPoint {
        case .newEpisodes:
            completionHandler(testCodableData,nil,nil)
        default: break
        }
       return urlSessionDataTaskMock
    }
}
struct TestCodableModel: Codable {
    var data : TestCoding?
}
struct TestCoding: Codable {
    var name: String?
}
