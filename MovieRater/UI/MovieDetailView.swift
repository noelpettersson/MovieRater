//
//  MovieDetailView.swift
//  MovieRater
//
//  Created by Anders Pettersson on 2023-08-08.
//

import SwiftUI
import Firebase


struct MovieDetailView: View {
    let movie: Movie
    @State private var hasUserVoted: Bool = false
    @State private var voteCount: Int = 0
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(movie.title)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .padding(.top, 20)
                
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.poster_path ?? "")")) { phase in
                    switch phase {
                    case .empty:
                        Image(systemName: "film")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 300)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.top, 10)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 300)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.top, 10)
                    case .failure:
                        Image(systemName: "film")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 300)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.top, 10)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)
                    Text("Release Date: \(movie.release_date ?? "")")
                        .foregroundColor(.gray)
                }
                
                
                Text("Overview")
                    .font(.headline)
                    .padding(.top, 10)
                
                Text(movie.overview ?? "")
                    .foregroundColor(.secondary)
                    .lineLimit(nil)
                
                HStack {
                    Image(systemName: "hand.thumbsup.fill")
                            .foregroundColor(.green)
                        Text("Vote Count: \(voteCount)")
                            .foregroundColor(.green)
                    }
                               
                    Button(action: {
                        voteForMovie()
                    }) {
                    Text(hasUserVoted ? "Voted" : "Vote")
                        .foregroundColor(.white)
                        .padding()
                        .background(hasUserVoted ? Color.gray : Color.blue)
                        .cornerRadius(10)
                    }
                        .disabled(hasUserVoted)
                        .padding()
                    }
                    .onAppear {
                    checkUserVote()
                    fetchVoteCount() // Fetch vote count on appearance
                    }
                    .padding()
                    }
                }
    
    func fetchVoteCount() {
           // Fetch the vote count from Firestore
           let db = Firestore.firestore()
           let movieDocRef = db.collection("movie_ratings").document(String(movie.id))
           
           movieDocRef.getDocument { document, error in
               if let document = document, let data = document.data(), let votedUsers = data["votedUsers"] as? [String] {
                   self.voteCount = votedUsers.count
               }
           }
       }
    
    func checkUserVote() {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }

        // Query Firestore to check if the user has voted for this movie
        let db = Firestore.firestore()
        db.collection("movie_ratings").document(String(movie.id)).getDocument { document, error in
            if let document = document, document.exists {
                if let votedUsers = document.data()?["votedUsers"] as? [String] {
                    self.hasUserVoted = votedUsers.contains(userID)
                }
            }
        }
    }

    func voteForMovie() {
        guard !hasUserVoted else {
            print("User has already voted for this movie")
            return
        }

        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }

        // Update Firestore to record the user's vote
        let db = Firestore.firestore()
        let movieDocRef = db.collection("movie_ratings").document(String(movie.id))

        movieDocRef.setData(["votedUsers": FieldValue.arrayUnion([userID])], merge: true) { error in
            if let error = error {
                print("Error voting: \(error)")
            } else {
                print("User voted successfully")
                self.hasUserVoted = true
            }
        }
    }
}
