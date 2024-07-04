//
//  ContentView.swift
//  Flickr_CVS
//
//  Created by Alexander Adegbenro on 7/3/24.
//

import SwiftUI

struct SearchBarView: View {
    @ObservedObject var viewmodel: ImageSearchViewModel
    
    var body: some View {
        TextField("Search...", text: $viewmodel.searchText)
            .padding(7)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 10)
    }
}


#Preview {
    ContentView()
}
