//
//  ImageDetailView.swift
//  Flickr_CVS
//
//  Created by Alexander Adegbenro on 7/3/24.
//

import SwiftUI

import SwiftUI

struct ImageDetailView: View {
    var image: ImageModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: image.imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .padding()
                    @unknown default:
                        EmptyView()
                    }
                }
                
                Text(image.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding([.top, .horizontal])
                
                if let description = image.description.htmlToAttributedString {
                    Text(description.string)
                        .font(.body)
                        .padding(.horizontal)
                }
                
                HStack {
                    Text("Author: ")
                        .fontWeight(.semibold)
                    Text(image.author)
                }
                .font(.footnote)
                .padding(.horizontal)
                
                HStack {
                    Text("Published: ")
                        .fontWeight(.semibold)
                    Text(image.published, style: .date)
                }
                .font(.footnote)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle(image.title, displayMode: .inline)
    }
}

struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleImage = ImageModel(
            title: "Sample Image",
            description: "This is a sample description for the image.",
            author: "John Doe",
            published: Date(),
            imageURL: URL(string: "https://via.placeholder.com/150")!
        )
        ImageDetailView(image: sampleImage)
    }
}
