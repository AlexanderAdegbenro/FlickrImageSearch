//
//  URLSession+Extensions.swift
//  Flickr_CVS
//
//  Created by Alexander Adegbenro on 7/3/24.
//

import Foundation
import Combine

extension URLSession {
    func dataTaskPublisher(for url: URL) -> AnyPublisher<Data, URLError> {
        return dataTaskPublisher(for: URLRequest(url: url))
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
