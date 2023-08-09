//
//  MovieDetailView.swift
//  MovieRater
//
//  Created by Anders Pettersson on 2023-08-08.
//

import SwiftUI


struct MovieDetailView: View {
    let movie: Movie
    
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
                
                HStack {
                    Image(systemName: "tag")
                        .foregroundColor(.gray)
                    Text("Genre: \(movie.genre ?? "")")
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Image(systemName: "globe")
                        .foregroundColor(.gray)
                    Text("Origin Country: \(movie.origin_country ?? "")")
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.gray)
                    Text("Runtime: \(movie.runtime ?? 0) minutes")
                        .foregroundColor(.gray)
                }
                
                Text("Overview")
                    .font(.headline)
                    .padding(.top, 10)
                
                Text(movie.overview ?? "")
                    .foregroundColor(.secondary)
                    .lineLimit(nil)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let mockMovie = Movie(
            id: 123,
            title: "Shrek",
            backdrop_path: "backdrop_path",
            poster_path: "poster_path",
            overview: "Overview of the movie",
            vote_average: 7.5,
            vote_count: 1000,
            runtime: 120,
            release_date: "2023-08-09",
            genre: "Animation, Comedy",
            origin_country: "USA"
        )
        
        return MovieDetailView(movie: mockMovie)
    }
}
