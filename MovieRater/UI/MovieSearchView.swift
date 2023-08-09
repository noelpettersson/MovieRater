//
//  MovieSearchView.swift
//  MovieRater
//
//  Created by Anders Pettersson on 2023-08-08.
//

import SwiftUI

import SwiftUI

struct MovieSearchView: View {
    @State private var query: String = ""
    @State private var showMovies: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter movie title", text: $query)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Search") {
                    showMovies = true
                }
                
                if showMovies {
                    NavigationLink(destination: MovieSearchList(query: query), isActive: $showMovies) {
                        EmptyView()
                    }
                    .hidden()
                }
            }
            .padding()
        }
    }
}
struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
