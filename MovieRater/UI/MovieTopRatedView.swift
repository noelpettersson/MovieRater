//
//  MovieTopRatedView.swift
//  MovieRater
//
//  Created by Anders Pettersson on 2023-08-08.
//

import SwiftUI
import Firebase

struct MovieTopRatedView: View {
    @State private var topRatedMovieIDs: [String] = []
    @State private var topRatedMovies: [Movie] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Top Rated Movies") // Display a title for the view
                List(topRatedMovies) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        Text(movie.title) // Display each movie title in a list
                    }
                }
            }
            .onAppear {
                topRatedMovies.removeAll() // Clear the list before fetching new data
                fetchTopRatedMovieIDs() // Fetch the top rated movie IDs and their details
            }
        }
    }
    
    // Function to fetch the top rated movie IDs from Firestore
    func fetchTopRatedMovieIDs() {
        let db = Firestore.firestore()
        db.collection("movie_ratings").order(by: "votedUsers", descending: true).limit(to: 10).getDocuments { snapshot, error in
            if let documents = snapshot?.documents {
                let topRatedIDs = documents.compactMap { document in
                    return document.documentID
                }
                self.topRatedMovieIDs = topRatedIDs
                
                fetchTopRatedMovieDetails() // Fetch movie details for the top rated movies
            }
        }
    }
    
    // Function to fetch the details for the top rated movies
    func fetchTopRatedMovieDetails() {
        let group = DispatchGroup() // Create a dispatch group to track asynchronous tasks
        
        for movieID in topRatedMovieIDs {
            if let id = Int(movieID) {
                group.enter() // Notify the group that a task is about to begin
                
                // Fetch movie details using MovieService
                MovieService().fetchMovieDetailsByID(id: id) { result in
                    switch result {
                    case .success(let movie):
                        DispatchQueue.main.async {
                            self.topRatedMovies.append(movie) // Add fetched movie to the list
                        }
                    case .failure(let error):
                        print("Error fetching movie details:", error)
                    }
                    
                    group.leave() // Notify the group that the task is complete
                }
            }
        }
        
        // Wait for all tasks in the group to complete
        group.notify(queue: .main) {
            // All movie details have been fetched
            print("All movie details fetched")
        }
    }
}
