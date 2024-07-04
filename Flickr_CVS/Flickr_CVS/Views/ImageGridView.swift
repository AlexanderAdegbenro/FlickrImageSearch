//
//  ImageGridView.swift
//  Flickr_CVS
//
//  Created by Alexander Adegbenro on 7/3/24.
//
import SwiftUI

struct ImageGridView: View {
    var images: [ImageModel]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 16)]) {
                ForEach(images) { image in
                    NavigationLink(destination: ImageDetailView(image: image)) {
                        AsyncImageView(url: image.imageURL)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                    }
                }
            }
            .padding()
        }
    }
}

struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView(images: [
            ImageModel(title: "Sample 1", description: "Description 1", author: "Author 1", published: Date(), imageURL: URL(string: "https://via.placeholder.com/150")!),
            ImageModel(title: "Sample 2", description: "Description 2", author: "Author 2", published: Date(), imageURL: URL(string: "https://via.placeholder.com/150")!)
        ])
    }
}
