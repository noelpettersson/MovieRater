//
//  MovieSearchList.swift
//  MovieRater
//
//  Created by Anders Pettersson on 2023-08-09.
//

import SwiftUI

struct MovieSearchList: View {
    @State private var movies: [Movie] = []
       @State private var selectedMovieID: Int?
       let query: String
       
       init(query: String) {
           self.query = query
       }
       
       var body: some View {
           VStack {
               Text("Top Rated Movies for '\(query)'")
               List(movies) { movie in
                   NavigationLink(destination: MovieDetailView(movie: movie)) {
                       Text(movie.title)
                   }
               }
           }
           .onAppear {
               fetchMovies()
           }
       }
       
       func fetchMovies() {
           MovieService().searchMovieTitle(query: query) { result in
               switch result {
               case .success(let movieResponse):
                   self.movies = movieResponse.results
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
