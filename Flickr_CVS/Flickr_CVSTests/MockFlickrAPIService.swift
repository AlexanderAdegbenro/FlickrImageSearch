//
//  MockFlickrAPIService.swift
//  Flickr_CVSTests
//
//  Created by Alexander Adegbenro on 7/3/24.
//
import Foundation
import Combine
@testable import Flickr_CVS

class MockFlickrAPIService: FlickrAPIServiceProtocol {
    static var mockImages: [ImageModel] = []
    static var shouldReturnError = false

    static func fetchImages(urlString: String) -> AnyPublisher<[ImageModel], Error> {
        if shouldReturnError {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        } else {
            return Just(mockImages)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}

