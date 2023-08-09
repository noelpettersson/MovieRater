//
//  MovieTopRatedView.swift
//  MovieRater
//
//  Created by Anders Pettersson on 2023-08-08.
//

import SwiftUI

struct MovieTopRatedView: View {
    @State private var movies: [Movie] = []
    @State private var selectedMovieID: Int?
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Top Rated Movies")
                List(movies) { movie in
                    NavigationLink(destination: MovieDetailView(movieID: movie.id)) {
                        Text(movie.title)
                    }
                }
            }
            .onAppear {
                fetchMovies()
            }
        }
    }
    
    func fetchMovies() {
        MovieService().searchMovieTitle(query: "shrek") { result in
            switch result {
            case .success(let movieResponse):
                self.movies = movieResponse.results
            case .failure(let error):
                print("Error fetching movies: \(error)")
            }
        }
    }
}
