//
//  FlickrAPIServiceProtocol.swift
//  Flickr_CVS
//
//  Created by Alexander Adegbenro on 7/3/24.
//

import Foundation
import Combine

protocol FlickrAPIServiceProtocol {
    static func fetchImages(urlString: String) -> AnyPublisher<[ImageModel], Error>
}

extension FlickrAPIService: FlickrAPIServiceProtocol {}
