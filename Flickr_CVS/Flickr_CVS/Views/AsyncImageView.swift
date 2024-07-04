//
//  AsyncImageView.swift
//  Flickr_CVS
//
//  Created by Alexander Adegbenro on 7/3/24.
//

import SwiftUI
import Combine

struct AsyncImageView: View {
    @StateObject private var imageCache = ImageCache.shared
    let url: URL

    @State private var image: UIImage? = nil
    @State private var cancellable: AnyCancellable?

    var body: some View {
        ZStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
            } else {
                ProgressView()
                    .onAppear {
                        loadImage()
                    }
            }
        }
        .onReceive(imageCache.$images) { images in
            self.image = images[url]
        }
    }

    private func loadImage() {
        if let cachedImage = imageCache.image(for: url) {
            self.image = cachedImage
        } else {
            cancellable = imageCache.loadImage(from: url)
                .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
        }
    }
}

