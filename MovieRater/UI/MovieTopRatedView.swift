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
                    Text("Top Rated Movies")
                    List(topRatedMovies) { movie in
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            Text(movie.title)
                        }
                    }
                }
                .onAppear {
                    topRatedMovies.removeAll() // Clear the list before fetching new data
                    fetchTopRatedMovieIDs()
                }
            }
        }

        // ... your other functions ...

        func fetchTopRatedMovieIDs() {
            let db = Firestore.firestore()
            db.collection("movie_ratings").order(by: "votedUsers", descending: true).limit(to: 10).getDocuments { snapshot, error in
                if let documents = snapshot?.documents {
                    let topRatedIDs = documents.compactMap { document in
                        return document.documentID
                    }
                    self.topRatedMovieIDs = topRatedIDs

                    fetchTopRatedMovieDetails() // Fetch movie details here
                }
            }
        }

        func fetchTopRatedMovieDetails() {
            let group = DispatchGroup()

            for movieID in topRatedMovieIDs {
                if let id = Int(movieID) {
                    group.enter()

                    MovieService().fetchMovieDetailsByID(id: id) { result in
                        switch result {
                        case .success(let movie):
                            DispatchQueue.main.async {
                                self.topRatedMovies.append(movie)
                            }
                        case .failure(let error):
                            print("Error fetching movie details:", error)
                        }

                        group.leave()
                    }
                }
            }

            group.notify(queue: .main) {
                // All movie details have been fetched
                print("All movie details fetched")
            }
        }
    }
