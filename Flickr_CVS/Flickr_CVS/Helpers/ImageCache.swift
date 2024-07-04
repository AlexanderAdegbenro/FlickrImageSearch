//
//  ImageCache.swift
//  Flickr_CVS
//
//  Created by Alexander Adegbenro on 7/3/24.
//

import SwiftUI
import Combine

class ImageCache: ObservableObject {
    @Published private(set) var images: [URL: UIImage] = [:]
    private let cache = NSCache<NSURL, UIImage>()
    private var cancellables: [URL: AnyCancellable] = [:]

    static let shared = ImageCache()

    private init() {}

    func image(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL) ?? images[url]
    }

    func setImage(_ image: UIImage, for url: URL) {
        DispatchQueue.main.async {
            self.images[url] = image
            self.cache.setObject(image, forKey: url as NSURL)
        }
    }

    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let image = image(for: url) {
            return Just(image).eraseToAnyPublisher()
        }

        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .catch { _ in Just(nil) }
            .handleEvents(receiveOutput: { [weak self] image in
                if let image = image {
                    self?.setImage(image, for: url)
                }
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()

        cancellables[url] = publisher.sink(receiveCompletion: { [weak self] _ in
            self?.cancellables[url] = nil
        }, receiveValue: { _ in })

        return publisher
    }
}
