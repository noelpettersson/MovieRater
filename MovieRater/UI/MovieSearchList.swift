//
//  MovieSearchList.swift
//  MovieRater
//
//  Created by Anders Pettersson on 2023-08-09.
//

import SwiftUI

struct MovieSearchList: View {
    @State private var movies: [Movie] = [] // State variable to store the fetched movies

    var body: some View {
        VStack {
            Text("Top Rated Movies for") // Text indicating the section
            List(movies) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    Text(movie.title) // Display the title of each movie in a list
                }
            }
        }
        .onAppear {
            fetchMovies() // Call fetchMovies when the view appears
        }
    }
    
    func fetchMovies() {
        MovieService().searchMovieTitle(query: query) { result in
            switch result {
            case .success(let movieResponse):
                self.movies = movieResponse.results // Update the movies array with fetched movie data
            case .failure(let error):
                print("Error fetching movies: \(error)")
            }
        }
    }
}


struct MovieSearchList_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchList(query: "shrek")
    }
}
